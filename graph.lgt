:- object(graph(_PLP_,_DB_),implements(cond_graphp)).

:- protected(atom_of/2).

:- uses(list, [member/2]).

:- table condrule/3.


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



