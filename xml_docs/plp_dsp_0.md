
-------------------------------------------------------------------------------
# protocol: `plp_dsp`

A protocol representing a probabilistic logic program in the distribution semantics.

* availability: `built_in`

* compilation flags: `static`

* dependencies:
  (none)


## Inherited public predicates

(none)

## Public predicates

### <a name="probfact/2"></a>`probfact/2`

Probabilistic facts of the program.

* compilation flags: `static`
* template: `probfact(fact,probability)`
* mode - number of proofs:
  * `probfact(?term,?between(float,0,1))` - `zero_or_more`

### <a name="detrule/2"></a>`detrule/2`

Deterministic rules of the program.

* compilation flags: `static`
* template: `detrule(head,body)`
* mode - number of proofs:
  * `detrule(?term,?list(term))` - `zero_or_more`

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
