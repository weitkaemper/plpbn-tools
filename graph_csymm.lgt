:- object(graph_csymm(_PLP_,_DB_), extends(graph_psymm(_PLP_,_DB_))).
:- info([
	   comment is 'Extension of graph_2 with symmetries induced by conditions that share the same functors.',
	   parameters is ['PLP' - 'A probabilistic logic program conforming to plpp.',
					  'DB' - 'A database implementing background knowledge to the PLP.'],
	   see_also is [plpp, plp(_,_)]]).

symmetry(W,X,Y,Z) :-
	^^edge(W,X,C1),
	^^edge(Y,Z,C2),
	^^symmetry(W,X,Y,Z),
	sort(C1,C1sorted),
	sort(C2,C2sorted),
	equiv_conds(C1sorted,C2sorted).

equiv_conds([],[]).
equiv_conds([C|Cs],[D|Ds]) :-
	equiv_cond(C,D),
	equiv_conds(Cs,Ds).

equiv_cond(C,D) :-
	^^atom_of(C,CA),
	^^atom_of(D,DA),
	functor(CA,F,N),
	functor(DA,F,N).


:- end_object.
