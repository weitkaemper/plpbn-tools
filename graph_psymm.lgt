:- object(graph_psymm(_PLP_,_DB_), extends(graph(_PLP_,_DB_)),implements(symm_graphp)).

symmetry(W,X,Y,Z) :-
	functor(W,F,N1),
	functor(X,F2,N2),
	functor(Y,F,N1),
	functor(Z,F2,N2).


:- end_object.
