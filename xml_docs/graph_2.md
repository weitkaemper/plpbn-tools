
-------------------------------------------------------------------------------
# object: `graph(PLP,DB)`

dependency graph induced by a PLP and an associated DB.

* `PLP` - A probabilistic logic program conforming to plpp.* `DB` - A database implementing background knowledge to the PLP.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* implements:
  * `public` [`cond_graphp`](cond_graphp_0.md)
* uses:
  * [`list`](list_0.md)

## Inherited public predicates

[`edge/2`](graphp_0.md)  [`edge/3`](cond_graphp_0.md)  [`node/1`](graphp_0.md)  

## Public predicates

### <a name="oriented_edge/2"></a>`oriented_edge/2`

Edges whose orientation is already known.

* compilation flags: `static`
* template: `oriented_edge(source,destination)`
* mode - number of proofs:
  * `oriented_edge(?term,?term)` - `zero_or_more`
* remarks:
  * explanation: When the database declares and implements a predicate direction/2 between arguments, then oriented/2 pre-orients edges accordingly. Timesteps are a typical example.

## Protected predicates

### <a name="atom_of/2"></a>`atom_of/2`
* compilation flags: `static`

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

* [`plpp`](plpp_0.md)
* [`plp(parser,file)`](plp_2.md)

-------------------------------------------------------------------------------
