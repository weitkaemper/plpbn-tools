:- object(graph(_PLP_,_DB_),implements(cond_graphp)).
:- if(current_logtalk_flag(prolog_dialect, xsb)).
:- use_module(basics,[member/2]).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
:- use_module(library(lists),[member/2]).
:- endif.

:- table condrule/3.

:- protected(atom_of/2).

condrule(X,Y,C) :-
	_PLP_::probrule(X,_,Body),
	split_body(Body,Y,C),
	dbcheck(C).

edge(Y,X,C) :-
	condrule(X,Ys,C),
	member(YLit,Ys),
	atom_of(YLit,Y).

edge(X,Y) :-
	edge(X,Y,_).


%-- Utilities --%

atom_of(\+ A,A).
atom_of(A, A) :-
	\+functor(A, (\+),1).

split_body([],[],[]).

split_body([A|Body], Int, Ext) :-
      ( functor(A,F,N),
		external(F,N)
      ->  Ext = [A|E],
          split_body(Body, Int, E)
      ;   Int = [A|I],
          split_body(Body, I, Ext)
      ).

external(F,N) :-
	functor(T,F,N),
	_DB_::predicate_property(T, _).

dbcheck([]).
dbcheck([H|C]) :-
	_DB_::H,
	dbcheck(C).

:- end_object.



