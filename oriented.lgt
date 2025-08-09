:- object(oriented(_Graph_), implements(graphp)).
% _Graph_ is a graph with symmetries

:- public(verifiable/0).
verifiable :-
	forall(_Graph_::edge(X,Y), oriented_edge(X,Y)).

edge(X,Y) :-
	oriented_edge(X,Y).

node(X) :-
	_Graph_::node(X).

:- table oriented_edge/2.
:- table adjacent/2.
:- table collider/3.

oriented_edge(X,Y) :-
	_Graph_::current_predicate(oriented_edge/2),
	_Graph_::oriented_edge(X,Y).

oriented_edge(X,Y) :-
	collider_orientation(X,Y).
oriented_edge(X,Y) :-
	meek_orientation(X,Y).
oriented_edge(X,Y) :-
	chain_orientation(X,Y).
oriented_edge(X,Y) :-
	conforms_to_protocol(_Graph_,symm_graphp),
	symmetry_orientation(X,Y).
oriented_edge(X,Y) :-
	cycle_orientation(X,Y).

adjacent(X,Y) :-
	_Graph_::edge(X,Y).
adjacent(X,Y) :-
	_Graph_::edge(Y,X).

collider(X,Y,Z) :-
	_Graph_::edge(X,Y),
	_Graph_::edge(Z,Y),
	X \= Z,
	\+ adjacent(X,Z).


collider_orientation(X,Y) :-
	collider(X,Y,_).

cycle_orientation(X,Z) :-
	oriented_edge(X,Y),
	oriented_edge(Y,Z),
	adjacent(X,Z).

chain_orientation(Y,Z) :-
	adjacent(Y,Z),
	oriented_edge(X,Y),
	X \= Z,
	\+ collider(X,Y,Z),
	\+ adjacent(X,Z).

meek_orientation(W,Z) :-
	oriented_edge(X,Z),
	oriented_edge(Y,Z),
	adjacent(W,X),
	adjacent(W,Y),
	adjacent(W,Z),
	X \= Y,
	\+ adjacent(X,Y).

meek_orientation(W,Y) :-
	oriented_edge(X,Z),
	oriented_edge(Z,Y),
	adjacent(W,X),
	adjacent(W,Y),
	adjacent(W,Z),
	X \= Y,
	\+ adjacent(X,Y).


symmetry_orientation(X,Y) :-
	adjacent(X,Y),
	adjacent(Y,Z),
	X \= Z,
	_Graph_::symmetry(X,Y,Z,Y).

symmetry_orientation(X,Y) :-
	adjacent(X,Y),
	_Graph_::symmetry(X,Y,W,Z),
	oriented_edge(W,Z).

:- end_object.
















