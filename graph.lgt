:- object(graph(_PLP_,_DB_),implements(cond_graphp)).
:- info([
	   comment is 'dependency graph induced by a PLP and an associated DB.',
	   parameters is ['PLP' - 'A probabilistic logic program conforming to plpp.',
					  'DB' - 'A database implementing background knowledge to the PLP.'],
	   see_also is [plpp, plp(_,_)]]).

:- protected(atom_of/2).

:- uses(list, [member/2]).

:- if(current_logtalk_flag(tabling,supported)).
:- table condrule/3.
:- table edge/2.
:- endif.

:- public(oriented_edge/2).
:- mode(oriented_edge(?term,?term),zero_or_more).
:- info(oriented_edge/2,[
						  comment is 'Edges whose orientation is already known.',
						  remarks is [explanation - 'When the database declares and implements a predicate direction/2 between arguments, then oriented/2 pre-orients edges accordingly. Timesteps are a typical example.'],
						  argnames is [source,destination]]).

condrule(X,Y,C) :-
	_PLP_::probrule(X,_,Body),
	split_body(Body,Y,C),
	dbcheck(C).

node(X) :-
	_PLP_::probrule(X,_,_).

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

oriented_edge(X,Y) :-
	_DB_::current_predicate(direction/2),
	edge(X,Y),
	X =.. [_|XArgs],
	Y =.. [_|YArgs],
	member(T1,XArgs),
	member(T2,YArgs),
	_DB_::direction(T1,T2).


:- end_object.



