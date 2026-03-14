:- protocol(lpmlnp).

:- info([comment is 'Protocol for LP-MLN programs.']).

:- public(weightrule/3).
:- mode(weightrule(?term,?between(float,0,1),?list(term)),zero_or_more).
:- info(weightrule/3, [
					 comment is 'Weighted rules of the program.',
					 argnames is [head,weight,body]]).

:- public(detrule/2).
:- mode(detrule(?term,?list(term)),zero_or_more).
:- info(detrule/2, [
					comment is 'Deterministic rules of the program.',
					argnames is [head,body]]).


:- end_protocol.

