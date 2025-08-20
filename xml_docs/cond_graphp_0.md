
-------------------------------------------------------------------------------
# protocol: `cond_graphp`

Protocol for graphs that track reasons for edges to exist.

* availability: `built_in`

* compilation flags: `static`

* extends:
  * `public` [`graphp`](graphp_0.md)

## Inherited public predicates

[`edge/2`](graphp_0.md)  [`node/1`](graphp_0.md)  

## Public predicates

### <a name="edge/3"></a>`edge/3`

Edges, with conditions attached to them.

* compilation flags: `static`
* template: `edge(source,destination,condition)`
* mode - number of proofs:
  * `edge(?term,?term,?term)` - `zero_or_more`
* remarks:
  * Explanation: The third argument expresses a (satisfied) condition for the edge to exist. So, this protocol is not for edges that may exist, but for edges that are known to exist, but for which additionally a reason for their existence is known.

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
