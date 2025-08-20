:- protocol(plp_dsp).
:- info([comment is 'A protocol representing a probabilistic logic program in the distribution semantics.']).

:- public(probfact/2).
:- mode(probfact(?term,?between(float,0,1)),zero_or_more).
:- info(probfact/2, [
					comment is 'Probabilistic facts of the program.',
					argnames is [fact,probability]]).

:- public(detrule/2).
:- mode(detrule(?term,?list(term)),zero_or_more).
:- info(detrule/2, [
					comment is 'Deterministic rules of the program.',
					argnames is [head,body]]).

:- end_protocol.
