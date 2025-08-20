:- object(d-separation).
:- info([comment is 'Tools for d-separation in a directed acyclic graph.',
        see_also is [graphp]]).

:- public(dconnects/4).
:- mode(dconnects(+object,+term,+term,+list(term)),zero_or_one).
:- info(dconnects/4, [
                     comment is 'D-connection in a directed acyclic graph.',
                     arguments is [graph - 'Object implementing graphp.',
                                  'X' - 'First node.',
                                  'Y' - 'Second node.',
                                  'Z' - 'Set of nodes d-connecting X and Y.']]).
:- public(dseparates/4).
:- mode(dseparates(+object,+term,+term,+list(term)),zero_or_one).
:- info(dseparates/4, [
                     comment is 'D-separation in a directed acyclic graph.',
                     arguments is [graph - 'Object implementing graphp.',
                                  'X' - 'First node.',
                                  'Y' - 'Second node.',
                                  'Z' - 'Set of nodes d-separating X and Y.']]).

:- if(current_logtalk_flag(tabling,supported)).
:- table(dconnects/5).
:- table(hactivates/3).
:- endif.
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

% dseparates/4 is the complement of dconnects/4

dseparates(Graph,X,Y,Z) :-
    \+dconnects(Graph,X,Y,Z).

:- end_object.











