:- object(graph_psymm(_PLP_,_DB_), extends(graph(_PLP_,_DB_)),implements(symm_graphp)).
:- info([
	   comment is 'Extension of graph_2 with symmetries induced by nodes sharing the same functors.',
	   parameters is ['PLP' - 'A probabilistic logic program conforming to plpp.',
					  'DB' - 'A database implementing background knowledge to the PLP.'],
	   see_also is [plpp, plp(_,_)]]).


symmetry(W,X,Y,Z) :-
	functor(W,F,N1),
	functor(X,F2,N2),
	functor(Y,F,N1),
	functor(Z,F2,N2).


:- end_object.
