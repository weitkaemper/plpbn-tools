:- object(lewis_cf(_BN_), implements(plp_dsp)).
% _BN_ implements bnp.

:- if(current_logtalk_flag(prolog_dialect, xsb)).
:- use_module(string,[concat_atom/3]).
atomic_list_concat(A,B,C) :-
	concat_atom(A,B,C).
:- endif.
%:- uses(gensym,[gensym/2, reset_gensym/0]).
%:- uses(bintree,[]).
:- uses(pairs,[keys_values/3 as pairs_keys_values/3, group_sorted_by_key/2, keys/2 as pairs_keys/2, values/2 as pais_values/2]).
:- uses(list,[length/2,append/3,member/2]).
%:- uses(set, [union/3,insert/3]).

:- uses(_BN_,[node/1,edge/2,cpt/3]).

%:- table poss_probs/2.
%:- table rules/9.

parent_val(Node,Val) :-
	findall(Par,edge(Par,Node),KeysUnsorted),
	sort(KeysUnsorted,Keys),
	length(Keys,N),
	truefalses(N,Values),
	pairs_keys_values(Val,Keys,Values).

poss_probs(Node,ProbVals) :-
	findall(R-Val,poss_prob(Node,Val,R),ProbValsUnsorted),
	group_sorted_by_key(ProbValsUnsorted,ProbVals).

poss_prob(Node,Val,R) :-
	parent_val(Node,Val),
	cpt(Node,Val,R).

%probfact(Fact,R) :-
%	node(Node),
%	poss_probs(Node,ValProbs),
%	pairs_keys(ValProbs,Probs),
%	probfact_aux(Node,Probs,0,Fact,R).

probfact(Fact,R) :-
	node(Node),
	poss_probs(Node,ProbVals),
	rules(Node,ProbVals,0,[],[],[],Probrules,_,_),
	member(pfact(Fact,R),Probrules).

detrule(Head,Body) :-
	node(Node),
	poss_probs(Node,ProbVals),
	rules(Node,ProbVals,0,[],[],[],_,Detrules,_),
	member(detrule(Head,Body),Detrules).
detrule(Head,Body) :-
	node(Node),
	poss_probs(Node,ProbVals),
	rules(Node,ProbVals,0,[],[],[],_,_,Auxrules),
	member(detrule(Head,Body),Auxrules).

rules(_,[],_,Ps,Ds,As,Ps,Ds,As).
rules(Node,[R-Vals|ProbVals],N,PAcc,DAcc,AAcc,Probrules,Detrules,Auxrules) :-
	pfactname(Node,N,PFact),
	detrules(Node,N,0,Vals,NDetrules,[],NAuxrules),
	NewPAcc = [pfact(PFact,R)|PAcc],
	append(DAcc,NDetrules,NewDAcc),
	append(AAcc,NAuxrules,NewAAcc),
	M is N + 1,
	newprobvals(R,ProbVals,NewProbVals),
	rules(Node,NewProbVals,M,NewPAcc,NewDAcc,NewAAcc,Probrules,Detrules,Auxrules).

detrules(_,_,_,[],[],Aux,Aux).
detrules(Node,N,A,[Val|Vals],[detrule(Node,[Err|Body])|Detrules],Acc,Auxrules) :-
	val_to_body(Val,Body),
	errtermname(Node,N,A,Err),
	auxrules(Node,Err,N,NewAuxrules),
	append(Acc,NewAuxrules,NewAcc),
	B is A + 1,
	detrules(Node,N,B,Vals,Detrules,NewAcc,Auxrules).

auxrules(Node,Err,N,[detrule(Err,[PFact])|Auxrules]) :-
	N >= 0,
	pfactname(Node,N,PFact),
	M is N - 1,
	auxrules(Node,Err,M,Auxrules).
auxrules(_,_,N,[]) :-
	N < 0.

%probfact_aux(Node,[R|_],N,Fact,R) :-
%	pfactname(Node,N,Fact).
%probfact_aux(Node,[_|Probs],N,Fact,R) :-
%	newprobs(R,Probs,NewProbs),
%	M is N + 1,
%	probfact_aux(Node,NewProbs,M,Fact,R).

%probfacts_aux(_,[],_,PFacts,PFacts).
%probfacts_aux(Node,[R|Probs],N,Acc,PFacts) :-
%	newprobs(R,Probs,NewProbs),
%	pfactname(Node,N,Fact),
%	M is N + 1,
%	probfacts_aux(Node,NewProbs,M,[Fact-R|Acc],PFacts).

%detrule(Head,Body) :-
%	node(Node),
%	setof(Val,parent_val(Node,Val),Vals),
%	detrule_aux(Node,Vals,0,Head,Body,_,_).
%
%detrule_aux(Node,[Val|_],N,Err,Node,[Err|Body]) :-
%	val_to_body(Val,Body),
%	errtermname(Node,N,Err).
%detrule_aux(Node,[_|Vals],N,Err,Node,Body) :-
%	M is N + 1,s
%	detrule_aux(Node,Vals,M,Err,Node,Body).

newprobvals(_,[],[]).
newprobvals(R,[P-Val|ProbVals],[NewP-Val|NewProbVals]) :-
	noisy_or(R,NewP,P),
	newprobvals(R,ProbVals,NewProbVals).

pfactname(Node,N,PFact) :-
	atomic_list_concat([c,Node,N],'_',PFact).

errtermname(Node,N,A,Err) :-
	atomic_list_concat([a,Node,N,A],'_',Err).
val_to_body([],[]).
val_to_body([Atom-true|Tail],[Atom|Body]) :-
	val_to_body(Tail,Body).
val_to_body([Atom-false|Tail],[\+ Atom|Body]) :-
	val_to_body(Tail,Body).


noisy_or(X,Y,Z) :-
	nonvar(X),
	nonvar(Y),
	!,
	Z is X + Y - X*Y.

noisy_or(X,Y,Z) :-
	var(X),
	!,
	X is (Z - Y) / (1 - Y).

noisy_or(X,Y,Z) :-
	var(Y),
	Y is (Z - X) / (1 - X).


truefalses(0,[]).
truefalses(N,[true|List]) :-
	N > 0,
	M is N - 1,
	truefalses(M,List).
truefalses(N,[false|List]) :-
	N > 0,
	M is N - 1,
	truefalses(M,List).

:- end_object.























































