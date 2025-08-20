
-------------------------------------------------------------------------------
# protocol: `parserp`

A protocol for parsers of probabilistic logic programs.

* availability: `built_in`

* compilation flags: `static`

* dependencies:
  (none)


## Inherited public predicates

(none)

## Public predicates

### <a name="plp_rules/3"></a>`plp_rules/3`

Parses a list of codes into probabilistic and deterministic rules.

* compilation flags: `static`
* template: `plp_rules(probabilistic logic program,probabilistic rules,deterministic rules)`
  * `probabilistic logic program` - Some probabilistic logic program encoded in a list of codes.
  * `probabilistic rules` - A list of probabilistic rules, expressed as compounds of the form probrule(head:term, probability:between(float,0,1), body:list).
  * `deterministic rules` - A list of deterministic rules, expressed as standard Prolog clauses.
* mode - number of proofs:
  * `plp_rules(+list(codes),-list(compound),-list(compound))` - `zero_or_more`

## Protected predicates

(none)

## Private predicates

(none)

## Operators

(none)

## Remarks

(none)

## See also

(none)


-------------------------------------------------------------------------------
