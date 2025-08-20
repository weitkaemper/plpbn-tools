
-------------------------------------------------------------------------------
# object: `plp_dsc`

Utility class for probabilistic logic programs in the distribution semantics.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* implements:
  * `public` [`writerp`](writerp_0.md)
  * `public` [`plp_dsp`](plp_dsp_0.md)
* instantiates:
  * `public` [`plp_dsc`](plp_dsc_0.md)
* uses:
  * [`entity_writer_util`](entity_writer_util_0.md)

## Inherited public predicates

[`create_entity/1`](writerp_0.md)  [`detrule/2`](plp_dsp_0.md)  [`probfact/2`](plp_dsp_0.md)  [`write_entity/1`](writerp_0.md)  

## Public predicates

### <a name="write_problog/1"></a>`write_problog/1`

Write PLP to a ProbLog-compatible file.

* compilation flags: `static`
* template: `write_problog(identifier)`
  * `identifier` - Identifier, from which the file name is obtained by appending the .plp file ending.
* mode - number of proofs:
  * `write_problog(+atom)` - `one`
* remarks:
  * explanation: Writes PLP to a file ending in .plp that can be used as imput by PLP systems that can read ProbLog notation. This includes cplint, ProbLog 2 and the Counterfactuals Python package.

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
