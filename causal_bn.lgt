:- object(asp_penalty(_LPMLN_)).

:- uses(list, [member/2]).
:- uses(pairs, [value/3]).

:- table all_weightrules/1.

:- public detrule/2.
:- public term_weight/2.

detrule(H,B) :-
	_LPMLN_::detrule(H,B).
detrule(U,[not(H)|B]) :-
	all_weightrules(KVList),
	member(N-weightrule(H,_,B),KVList),
	weightrule_term(H,B,N,U).
detrule(H,[not(U)|B]) :-
	all_weightrules(KVList),
	member(N-weightrule(H,_,B),KVList),
	weightrule_term(H,B,N,U).

term_weight(N,W) :-
	all_weightrules(KVList),
	value(KVList,N,weightrule(_,W,_)).


all_weightrules(KVList) :-
	findall(weightrule(Head,W,Body), _LPMLN_::weightrule(Head,W,Body), Rules),
	numbered_list(Rules,KVList).


weightrule_term(Head,Body,N,NewTerm) :-
	term_variables(Head-Body, Vars),
	NewTerm =.. ['u_',N|Vars].
numbered_list(List, Numbered) :-
    numbered_list_(List, 1, Numbered).

numbered_list_([], _, []).
numbered_list_([X|Xs], N, [N-X|Ys]) :-
    N1 is N + 1,
    numbered_list_(Xs, N1, Ys).

:- end_object.


:- object(causal_bn_ds(_PLP_), implements(categorical_bnp), extends(scc_factors(graph_ds(_PLP_)))).
:- info([comment is 'Bayesian networks implementing PLP as a possibly cyclic graph by considering the factor graph along its strongly connected components. Only works under SWI-Prolog, and requires installation of the SWI-Prolog clingo library.',
		parameters is ['PLP' - 'ground probabilistic logic program implementing plp_dsp'],
		see_also is [plp_dsp]]).

:- uses(list, [append/2, append/3, member/2, memberchk/2]).
:- uses(pairs, [keys/2]).
:- uses(meta,[map/3]).


:- use_module(library(clingo), [clingo_new/2, clingo_add/3, clingo_ground/2, clingo_solve/2]).
:- use_module(library(aggregate),[aggregate_all/3]).
:- meta_predicate(aggregate_all(*,0,*)).


:- table answer_set/3.
:- table answer_set/4.

domain(X,D) :-
	boolean_specification(X,D).

cpt([X],[X-true],[],P) :-
	_PLP_::probfact(X,P).

cpt([X],[X-false],[],P) :-
	_PLP_::probfact(X,ConvP),
	P is 1 - ConvP.

cpt(SCC,Spec,Specs,0) :-
	extensionals(SCC,Abducibles),
	append([Spec|Specs],CompleteSpecU),
	sort(CompleteSpecU,CompleteSpec),
	\+answer_set(subprogram_ds(_PLP_,SCC), Abducibles, CompleteSpec,_).

cpt(SCC,Spec,Specs,P) :-
	extensionals(SCC,Abducibles),
	append([Spec|Specs],CompleteSpecU),
	sort(CompleteSpecU,CompleteSpec),
	answer_set(subprogram_ds(_PLP_,SCC), Abducibles, CompleteSpec,_),
	append(Specs,PaSpec),
	aggregate_all(count,answer_set(subprogram_ds(_PLP_,SCC), Abducibles, PaSpec,_),N),
	P is 1/N.

answer_set(PLP, Abducs, ASet) :-
	abducible_string(Abducs,AbducibleString),
	make_rule_string(PLP,RuleString),
	clingo_new(C, []),
	clingo_add(C, base,
		   AbducibleString),
	clingo_add(C, base,
		   RuleString),
	clingo_ground(C,
		      [ base
		      ]),
	clingo_solve(C, ASet).

answer_set(PLP, Abducs, Spec,ASet) :-
	answer_set(PLP, Abducs, ASet),
	forall(member(P-true,Spec), memberchk(P,ASet)),
	forall(member(P-false,Spec), \+memberchk(P,ASet)).


abducible_string([],"").
abducible_string(Abducs,AbducibleString) :-
	Abducs \= [],
    atomic_list_concat(Abducs, '; ', Inner),
    format(string(AbducibleString), "{~w}.", [Inner]).

make_rule_string(PLP, RuleString) :-
	findall((HeadS :- Lits),(PLP::detrule(Head,Body), term_string(Head,HeadS), map(lit_string_asp,Body,Lits)),Detrules),
	map(clause_string, Detrules, Strings),
	atomics_to_string(Strings, RuleString).


extensionals(N,Parents) :-
	findall(Pa,(::edge(Pa,N)),Pas),
	append(Pas,ParentsU),
	sort(ParentsU,Parents).

boolean_specification([],[]).
boolean_specification([H|T],[H-true|Spec]) :-
	boolean_specification(T,Spec).
boolean_specification([H|T],[H-false|Spec]) :-
	boolean_specification(T,Spec).

clause_string((HeadS :- Lits),CS) :-
	atomics_to_string(Lits, ',', BodyS),
	format(string(CS), "~w :- ~w. ", [HeadS, BodyS]).

lit_string_asp(\+ Body,BodyS) :-
	!,
	term_string(Body,InnerBodyS),
	format(string(BodyS), "not ~w", [InnerBodyS]).
lit_string_asp(not(Body),BodyS) :-
	!,
	term_string(Body,InnerBodyS),
	format(string(BodyS), "not ~w", [InnerBodyS]).
lit_string_asp(Lit, S) :-
	term_string(Lit,S).



:- end_object.


:- object(causal_bn_lpmln(_LPMLN_), implements(categorical_bnp), extends(scc_factors(graph_lpmln(_LPMLN_)))).
:- info([comment is 'Bayesian networks implementing PLP as a possibly cyclic graph by considering the factor graph along its strongly connected components. Only works under SWI-Prolog, and requires installation of the SWI-Prolog clingo library.',
		parameters is ['PLP' - 'ground probabilistic logic program implementing plp_dsp'],
		see_also is [plp_dsp]]).

:- uses(list, [append/2, append/3, member/2, memberchk/2]).
:- uses(pairs, [keys/2]).
:- uses(meta,[map/3]).


:- use_module(library(clingo), [clingo_new/2, clingo_add/3, clingo_ground/2, clingo_solve/2]).
:- use_module(library(aggregate),[aggregate_all/3]).
:- meta_predicate(aggregate_all(*,0,*)).


:- table answer_set/3.
:- table answer_set/4.

domain(X,D) :-
	boolean_specification(X,D).

cpt(SCC,Spec,Specs,0) :-
	extensionals(SCC,Abducibles),
	append([Spec|Specs],CompleteSpecU),
	sort(CompleteSpecU,CompleteSpec),
	\+answer_set(asp_penalty(subprogram_lpmln(_LPMLN_,SCC)), Abducibles, CompleteSpec,_).

cpt(SCC,Spec,Specs,P) :-
	extensionals(SCC,Abducibles),
	append([Spec|Specs],CompleteSpecU),
	sort(CompleteSpecU,CompleteSpec),
	answer_set(asp_penalty(subprogram_lpmln(_LPMLN_,SCC)), Abducibles, CompleteSpec,AnswerSet),
	weight(SCC,AnswerSet,Weight),
	append(Specs,PaSpec),
	aggregate_all(sum(W),(answer_set(asp_penalty(subprogram_lpmln(_LPMLN_,SCC)), Abducibles, PaSpec,ASet), weight(SCC,ASet,W)),N),
	P is Weight/N.

weight(SCC,A,W) :-
	weightsum(SCC,A,WSum),
	W is exp(-WSum).

weightsum(SCC,A,WSum) :-
	weightsum(SCC,A,0,WSum).

weightsum(_,[],Acc,Acc).
weightsum(SCC,[U|Rest],Acc,WSum) :-
	U =.. ['u_',N|_],
	asp_penalty(subprogram_lpmln(_LPMLN_,SCC))::term_weight(N,W),
	NewAcc is Acc + W,
	weightsum(SCC,Rest,NewAcc,WSum).
weightsum(SCC,[U|Rest],Acc,WSum) :-
	\+(U =.. ['u_',_|_]),
	weightsum(SCC,Rest,Acc,WSum).



answer_set(PLP, Abducs, ASet) :-
	abducible_string(Abducs,AbducibleString),
	make_rule_string(PLP,RuleString),
	clingo_new(C, []),
	clingo_add(C, base,
		   AbducibleString),
	clingo_add(C, base,
		   RuleString),
	clingo_ground(C,
		      [ base
		      ]),
	clingo_solve(C, ASet).

answer_set(PLP, Abducs, Spec,ASet) :-
	answer_set(PLP, Abducs, ASet),
	forall(member(P-true,Spec), memberchk(P,ASet)),
	forall(member(P-false,Spec), \+memberchk(P,ASet)).


abducible_string([],"").
abducible_string(Abducs,AbducibleString) :-
	Abducs \= [],
    atomic_list_concat(Abducs, '; ', Inner),
    format(string(AbducibleString), "{~w}.", [Inner]).

make_rule_string(PLP, RuleString) :-
	findall((HeadS :- Lits),(PLP::detrule(Head,Body), term_string(Head,HeadS), map(lit_string_asp,Body,Lits)),Detrules),
	map(clause_string, Detrules, Strings),
	atomics_to_string(Strings, RuleString).


extensionals(N,Parents) :-
	findall(Pa,(::edge(Pa,N)),Pas),
	append(Pas,ParentsU),
	sort(ParentsU,Parents).

boolean_specification([],[]).
boolean_specification([H|T],[H-true|Spec]) :-
	boolean_specification(T,Spec).
boolean_specification([H|T],[H-false|Spec]) :-
	boolean_specification(T,Spec).

clause_string((HeadS :- Lits),CS) :-
	atomics_to_string(Lits, ',', BodyS),
	format(string(CS), "~w :- ~w. ", [HeadS, BodyS]).

lit_string_asp(\+ Body,BodyS) :-
	!,
	term_string(Body,InnerBodyS),
	format(string(BodyS), "not ~w", [InnerBodyS]).
lit_string_asp(not(Body),BodyS) :-
	!,
	term_string(Body,InnerBodyS),
	format(string(BodyS), "not ~w", [InnerBodyS]).
lit_string_asp(Lit, S) :-
	term_string(Lit,S).





:- end_object.

