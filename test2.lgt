:- object(test2, implements(symm_graphp)).

edge(a,b).
edge(b,c).
edge(c,d).
edge(d,e).

symmetry(_,_,_,_) :- fail.

:- end_object.
