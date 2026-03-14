:- object(subprogram_ds(_PLP_,_Heads_), instantiates(plp_dsc)).

:- info([comment is 'Those clauses of a PLP whose heads lie in a given list, together with their appropriate probabilistic facts.',
	   parameters is ['PLP' - 'A probabilistic logic program implementing plp_dsp.', 'Heads' - 'A list of goals that specify the heads to be included in the subprogram']]).
:- uses(list, [member/2]).

detrule(Head,Body) :-
	member(Head,_Heads_),
	_PLP_::detrule(Head,Body).

probfact(Fact,Prob) :-
	detrule(_,Body),
	member(Fact,Body),
	_PLP_::probfact(Fact,Prob).

:- end_object.

:- object(subprogram_lpmln(_LPMLN_,_Heads_), implements(lpmlnp)).

:- info([comment is 'Those clauses of an LP-MLN whose heads lie in a given list, together with their appropriate probabilistic facts.',
	   parameters is ['PLP' - 'An LP-MLN implementing lpmlnp.', 'Heads' - 'A list of goals that specify the heads to be included in the subprogram']]).
:- uses(list, [member/2]).

detrule(Head,Body) :-
	member(Head,_Heads_),
	_LPMLN_::detrule(Head,Body).

weightrule(Head,Weight,Body) :-
	member(Head,_Heads_),
	_LPMLN_::weightrule(Head,Weight,Body).

:- end_object.

