:- object(scc_factors(_Graph_), implements(graphp)).

:- info([comment is 'Factor graph of a directed graph along its strongly connected components.',
		parameters is [graph - 'Graph that implements graphp.'],
		see_also is [graphp]]).

:- uses(list,[member/2]).

:- table scc/1.
:- table scc/2.
:- table in_scc/2.
:- table path/3.
:- table edge/2.

node(Xs) :-
	scc(Xs).

edge(Xs,Ys) :-
	node(Xs),
	node(Ys),
	Xs \= Ys,
	member(X,Xs),
	member(Y,Ys),
	_Graph_::edge(X,Y).

in_scc(N,X) :-
	path(_Graph_,N,X),
	path(_Graph_,X,N).

scc(N,Xs) :-
	setof(X,in_scc(N,X),Xs).

scc(Xs) :-
	_Graph_::node(N),
	scc(N,Xs).

path(_,N,N).
path(_Graph_,X,Y) :-
	_Graph_::edge(X,Z),
	path(_Graph_,Z,Y).

:- end_object.
