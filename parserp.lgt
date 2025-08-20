:- protocol(parserp).
:- info([comment is 'A protocol for parsers of probabilistic logic programs.']).

:- public(plp_rules/3).
:- mode(plp_rules(+list(codes),-list(compound),-list(compound)),zero_or_more).
:- info(plp_rules/3, [
					  comment is 'Parses a list of codes into probabilistic and deterministic rules.',
					  arguments is [
									 'probabilistic logic program' - 'Some probabilistic logic program encoded in a list of codes.',
									 'probabilistic rules' - 'A list of probabilistic rules, expressed as compounds of the form probrule(head:term, probability:between(float,0,1), body:list).',
									 'deterministic rules' - 'A list of deterministic rules, expressed as standard Prolog clauses.']]).

:- end_protocol.

