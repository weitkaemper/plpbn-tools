:- protocol(plpp).
:- info([comment is 'Protocol for probabilistic logic programs in probabilistic rule representation.']).

:- public(probrule/3).
:- mode(probrule(?term,?between(float,0,1),?list(term)),zero_or_more).
:- info(probrule/3, [
					 comment is 'Probabilistic rules of the program.',
					 argnames is [head,probability,body]]).


:- end_protocol.
