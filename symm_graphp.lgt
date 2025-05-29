:- protocol(symm_graphp, extends(graphp)).

:- public(symmetry/4).
:- mode(symmetry(+term, +term, ?term, ?term), zero_or_more).

:- end_protocol.
