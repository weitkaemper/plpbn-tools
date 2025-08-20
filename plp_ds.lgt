:- object(plp_ds(_PLP_), instantiates(plp_dsc)).
% _PLP_ implements plpp.

:- public([create_entity/0]).

:- uses(os, [decompose_file_name/4]).
:- uses(list, [member/2, append/3]).


:- table probfact/3.
:- table all_probrules/1.

probfact(Head, P) :-
	probfact(Head, P, _).

probfact(NewTerm,P,N) :-
    all_probrules(PRules),
    member(N-probrule(H,P,B),PRules),
	atom_concat('u_',N,NewFunc),
	term_variables(probrule(H,P,B), Vars),
	NewTerm =.. [NewFunc|Vars].


detrule(Head, [Term|Body]) :-
    all_probrules(PRules),
    member(N-probrule(Head,_,Body),PRules),
	probfact(Term,_,N).

create_entity :-
	create_entity(ds(_PLP_)).

all_probrules(KVList) :-
	findall(probrule(Head,P,Body), (_PLP_::probrule(Head,P,Body)), Rules),
	numbered_list(Rules,KVList).


rule_from_clause(Clause, Head, Body) :-
    Clause = (Head :- BodyC),
    !,
    conj_to_list(BodyC,Body).

rule_from_clause(Clause, Head, []) :-
    Clause = Head.

numbered_list(List, Numbered) :-
    numbered_list_(List, 1, Numbered).

numbered_list_([], _, []).
numbered_list_([X|Xs], N, [N-X|Ys]) :-
    N1 is N + 1,
    numbered_list_(Xs, N1, Ys).

conj_to_list(','(A, B), [A|B1]) :- !,
	conj_to_list(B, B1).
conj_to_list(A, [A]).

:- end_object.



:- object(plp_ds(_Parser_,_File_), instantiates(plp_dsc)).
% _Parses_ implements parserp, _File_ is an atom.

:- public([create_entity/0, write_entity/0]).

:- uses(reader,[file_to_codes/2]).
:- uses(os, [decompose_file_name/4]).
:- uses(list, [append/3, member/2, nth1/3]).


:- table plp_from_file/2.
:- table probfact/3.
:- table rule_from_clause/3.

probfact(Head, P) :-
	probfact(Head, P, _).

probfact(NewTerm,P,N) :-
    plp_from_file(PRules,_),
    nth1(N,PRules,probrule(H,P,B)),
	atom_concat('u_',N,NewFunc),
	term_variables(probrule(H,P,B), Vars),
	NewTerm =.. [NewFunc|Vars].

detrule(Head, Body) :-
	plp_from_file(_,DRules),
	member(Clause,DRules),
	rule_from_clause(Clause, Head, Body).

detrule(Head, [Term|Body]) :-
	plp_from_file(PRules,_),
    nth1(N,PRules,probrule(Head,_,Body)),
	probfact(Term,_,N).

create_entity :-
    decompose_file_name(_File_, _, Name, _),
	create_entity(Name).
write_entity :-
    decompose_file_name(_File_, _, Name, _),
	write_entity(Name).



plp_from_file(PRules,DRules) :-
    file_to_codes(_File_, Codes),
    _Parser_::plp_rules(Codes,PRules,DRules).

rule_from_clause(Clause, Head, Body) :-
    Clause = (Head :- BodyC),
    !,
    conj_to_list(BodyC,Body).

rule_from_clause(Clause, Head, []) :-
    Clause = Head.

conj_to_list(','(A, B), [A|B1]) :- !,
	conj_to_list(B, B1).
conj_to_list(A, [A]).

:- end_object.

