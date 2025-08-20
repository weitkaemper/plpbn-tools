
-------------------------------------------------------------------------------
# object: `oriented(graph)`

Orientation rules for a directed graph with symmetries.

* `graph` - Graph that implements graphp. If the parameter object implements symm_graphp, then symmetries are taken into account for orienting the edges.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* implements:
  * `public` [`graphp`](graphp_0.md)

## Inherited public predicates

[`edge/2`](graphp_0.md)  [`node/1`](graphp_0.md)  

## Public predicates

### <a name="verifiable/0"></a>`verifiable/0`

Tests whether all edges of the parameter graph can be oriented.

* compilation flags: `static`
* mode - number of proofs:
  * `verifiable` - `zero_or_one`

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

* [`graphp`](graphp_0.md)
* [`symm_graphp`](symm_graphp_0.md)

-------------------------------------------------------------------------------
