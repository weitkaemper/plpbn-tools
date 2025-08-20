:- protocol(cond_graphp, extends(graphp)).
:- info([comment is 'Protocol for graphs that track reasons for edges to exist.']).

:- public(edge/3).
:- mode(edge(?term,?term,?term),zero_or_more).
:- info(edge/3, [
			   comment is 'Edges, with conditions attached to them.',
			   remarks is ['Explanation' - 'The third argument expresses a (satisfied) condition for the edge to exist. So, this protocol is not for edges that may exist, but for edges that are known to exist, but for which additionally a reason for their existence is known.'],
			  argnames is [source,destination,condition]]).

:- end_protocol.
