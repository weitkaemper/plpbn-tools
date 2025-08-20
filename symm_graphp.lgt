:- protocol(symm_graphp, extends(graphp)).
:- info([comment is 'A protocol for graphs with marked symmetries between edges.']).

:- public(symmetry/4).
:- mode(symmetry(+term, +term, ?term, ?term), zero_or_more).
:- info(symmetry/4, [
					comment is 'Symmetries enforced between edges that must be oriented in the same direction.',
					argnames is ['first source', 'first destination', 'second source', 'second destination'],
					remarks is ['Explanation' - 'symmetry(a,b,c,d) expresses the restriction that should there be a directed edge going from a to b, then any edge between c and d must be in the direction from c to d.']]).
:- end_protocol.
