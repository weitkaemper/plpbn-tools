
-------------------------------------------------------------------------------
# object: `plp_ds(parser,file)`

An object that extracts a probabilistic logic program in the distribution semantics from a parsed probabilistic logic program.

* `parser` - A parser implementing parserp.* `file` - A file descriptor (an atom) containing a probabilistic logic program to be parsed by the parser.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* instantiates:
  * `public` [`plp_dsc`](plp_dsc_0.md)
* uses:
  * [`list`](list_0.md)
  * [`os`](os_0.md)
  * [`reader`](reader_0.md)

## Inherited public predicates

[`create_entity/1`](writerp_0.md)  [`detrule/2`](plp_dsp_0.md)  [`probfact/2`](plp_dsp_0.md)  [`write_entity/1`](writerp_0.md)  [`write_problog/1`](plp_dsc_0.md)  

## Public predicates

### <a name="create_entity/0"></a>`create_entity/0`

Creates a dynamic object implementing plp_dsp, whose name is derived from the second parameter of the object.

* compilation flags: `static`
* mode - number of proofs:
  * `create_entity` - `one`

### <a name="write_entity/0"></a>`write_entity/0`

Writes probabilistic logic program to file whose name matches the second parameter.

* compilation flags: `static`
* mode - number of proofs:
  * `write_entity` - `one`

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

* [`parserp`](parserp_0.md)

-------------------------------------------------------------------------------
