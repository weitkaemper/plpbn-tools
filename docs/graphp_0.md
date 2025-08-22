
-------------------------------------------------------------------------------
# protocol: `graphp`

Protocol for directed graphs.

* availability: `built_in`

* compilation flags: `static`

* dependencies:
  (none)


## Inherited public predicates

(none)

## Public predicates

### <a name="node/1"></a>`node/1`

Nodes of the graph.

* compilation flags: `static`
* template: `node(node)`
* mode - number of proofs:
  * `node(?term)` - `zero_or_more`

### <a name="edge/2"></a>`edge/2`

Directed edges of the graph.

* compilation flags: `static`
* template: `edge(source,destination)`
* mode - number of proofs:
  * `edge(?term,?term)` - `zero_or_more`

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
