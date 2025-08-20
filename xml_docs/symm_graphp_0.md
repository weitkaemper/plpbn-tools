
-------------------------------------------------------------------------------
# protocol: `symm_graphp`

A protocol for graphs with marked symmetries between edges.

* availability: `built_in`

* compilation flags: `static`

* extends:
  * `public` [`graphp`](graphp_0.md)

## Inherited public predicates

[`edge/2`](graphp_0.md)  [`node/1`](graphp_0.md)  

## Public predicates

### <a name="symmetry/4"></a>`symmetry/4`

Symmetries enforced between edges that must be oriented in the same direction.

* compilation flags: `static`
* template: `symmetry(first source,first destination,second source,second destination)`
* mode - number of proofs:
  * `symmetry(+term,+term,?term,?term)` - `zero_or_more`
* remarks:
  * Explanation: symmetry(a,b,c,d) expresses the restriction that should there be a directed edge going from a to b, then any edge between c and d must be in the direction from c to d.

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

(none)


-------------------------------------------------------------------------------
