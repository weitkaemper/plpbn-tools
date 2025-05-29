:- object(graph_csymm(_PLP_,_DB_), extends(graph_psymm(_PLP_,_DB_)),implements(symm_graphp)).

symmetry(W,X,Y,Z) :-
	^^edge(W,X,C1),
	^^edge(Y,Z,C2),
	^^symmetry(W,X,Y,Z),
	equiv_conds(C1,C2).

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
