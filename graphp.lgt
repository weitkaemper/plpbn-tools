:- protocol(graphp).
:- info([
	   comment is 'Protocol for directed graphs.'
		]).

:- public(node/1).
:- mode(node(?term),zero_or_more).
:- info(node/1, [
				 comment is 'Nodes of the graph.',
				 argnames is [node]]).

:- public(edge/2).
:- mode(edge(?term,?term),zero_or_more).
:- info(edge/2, [
				comment is 'Directed edges of the graph.',
				argnames is [source,destination]]).

:- end_protocol.
