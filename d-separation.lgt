:- object(d-separation).

:- public([dconnects/4, dseparates/4]).

:- table dconnects/5.
:- table hactivates/3.

% Compute activates/2 as the transitive closure of edge/2 in a graph
% Graph (which implements graphp).

hactivates(_,X,X).
hactivates(Graph,Z,X) :-
    Graph::edge(Y,Z),
    hactivates(Graph,Y,X).
activates(Graph,[Z|_],X) :-
    hactivates(Graph,Z,X).
activates(Graph,[_|TZ],X) :-
    activates(Graph,TZ,X).

dconnects(Graph,X,Y,Z) :-
    \+member(X,Z),
    \+member(Y,Z),
    dconnects(Graph,X,Y,Z,_),
    !.


dconnects(Graph,X,Y,_,right) :-
    Graph::edge(X,Y).
dconnects(Graph,X,Y,_,left) :-
    Graph::edge(Y,X).
dconnects(Graph,X,Y,Z,right) :-
    Graph::edge(Y1,Y),
    \+member(Y1,Z),
    dconnects(Graph,X,Y1,Z,right).
dconnects(Graph,X,Y,Z,right) :-
    Graph::edge(Y1,Y),
    \+member(Y1,Z),
    dconnects(Graph,X,Y1,Z,left).
dconnects(Graph,X,Y,Z,left) :-
    Graph::edge(Y,Y1),
    \+member(Y1,Z),
    dconnects(Graph,X,Y1,Z,left).
dconnects(Graph,X,Y,Z,left) :-
    Graph::edge(Y, Y1),
    activates(Graph,Z,Y1),
    dconnects(Graph,X,Y1,Z,right).

% dseparates/3 is the complement of dconnects/3

dseparates(Graph,X,Y,Z) :-
    \+dconnects(Graph,X,Y,Z).

:- end_object.











