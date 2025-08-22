
-------------------------------------------------------------------------------
# object: `lewis_cf(BN)`

A probabilistic logic program under the distribution semantics corresponsing to a Bayesian network.

* `BN` - A Bayesian network, implementing bnp.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* instantiates:
  * `public` [`plp_dsc`](plp_dsc_0.md)
* uses:
  * [`list`](list_0.md)
  * [`pairs`](pairs_0.md)

## Inherited public predicates

[`create_entity/1`](writerp_0.md)  [`detrule/2`](plp_dsp_0.md)  [`probfact/2`](plp_dsp_0.md)  [`write_entity/1`](writerp_0.md)  [`write_problog/1`](plp_dsc_0.md)  

## Public predicates

(no local declarations; see entity ancestors if any)

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

* explanation: Implements a probabilistic logic program under the distribution semantics that minimises the distance (Lewis-Williamson heuristic) between real and counterfactual scenarios among all such programs that have the same interventional distributions as the Bayesian network supplied as a parameter.

## See also

* [`bnp`](bnp_0.md)

-------------------------------------------------------------------------------
