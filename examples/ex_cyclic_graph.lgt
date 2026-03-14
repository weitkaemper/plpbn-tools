:- object(ex_cyclic_graph, implements(graphp)).

node(p1).
node(p2).
node(q1).
node(q2).
node(q3).

edge(p1,p2).
edge(p2,p1).
edge(q1,q2).
edge(q2,q3).
edge(q3,q1).

edge(p2,q1).

:- end_object.
