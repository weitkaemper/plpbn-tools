
-------------------------------------------------------------------------------
# object: `plp_ds(PLP)`

An object converting a PLP from the probabilistic rule representation to the distribution semantics.

* `PLP` - A probabilistic logic program implementing plpp.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* instantiates:
  * `public` [`plp_dsc`](plp_dsc_0.md)
* uses:
  * [`list`](list_0.md)
  * [`os`](os_0.md)

## Inherited public predicates

[`create_entity/1`](writerp_0.md)  [`detrule/2`](plp_dsp_0.md)  [`probfact/2`](plp_dsp_0.md)  [`write_entity/1`](writerp_0.md)  [`write_problog/1`](plp_dsc_0.md)  

## Public predicates

### <a name="create_entity/0"></a>`create_entity/0`

Creates a dynamic object implementing plp_dsp called ds(PLP), where PLP is the parameter of the object.

* compilation flags: `static`
* mode - number of proofs:
  * `create_entity` - `one`

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

* [`plpp`](plpp_0.md)

-------------------------------------------------------------------------------
