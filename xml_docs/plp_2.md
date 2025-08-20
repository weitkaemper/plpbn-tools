
-------------------------------------------------------------------------------
# object: `plp(parser,file)`

An object that extracts an internal probabilistic logic program representation and a database from a parsed probabilistic logic program.

* `parser` - A parser implementing parserp.* `file` - A file descriptor (an atom) containing a probabilistic logic program to be parsed by the parser.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* instantiates:
  * `public` [`plpc`](plpc_0.md)
* uses:
  * [`entity_writer_util`](entity_writer_util_0.md)
  * [`list`](list_0.md)
  * [`os`](os_0.md)
  * [`reader`](reader_0.md)

## Inherited public predicates

[`create_entity/1`](writerp_0.md)  [`probrule/3`](plpp_0.md)  [`write_entity/1`](writerp_0.md)  

## Public predicates

### <a name="create_plp/0"></a>`create_plp/0`

Creates PLP (implementing plpp) as a dynamic object whose name matches the file name.

* compilation flags: `static`
* mode - number of proofs:
  * `create_plp` - `one`

### <a name="write_plp/0"></a>`write_plp/0`

Writes PLP (implementing plpp) to a file whose name matches the file name.

* compilation flags: `static`
* mode - number of proofs:
  * `write_plp` - `one`

### <a name="create_dbprotocol/0"></a>`create_dbprotocol/0`

Creates matching database protocol.

* compilation flags: `static`
* mode - number of proofs:
  * `create_dbprotocol` - `one`
* remarks:
  * explanation: Creates a dynamic protocol to be implemented by the background knowledge bases for the PLP.

### <a name="write_dbprotocol/0"></a>`write_dbprotocol/0`

Writes matching database protocol to file.

* compilation flags: `static`
* mode - number of proofs:
  * `write_dbprotocol` - `one`
* remarks:
  * explanation: Writes a dynamic protocol to be implemented by the background knowledge bases for the PLP. The file name is created by appending p to the file identifier.

### <a name="create_db/0"></a>`create_db/0`

Creates knowledge base (implementing matching DB protocol) as a dynamic object whose name appends _db to the file name.

* compilation flags: `static`
* mode - number of proofs:
  * `create_db` - `one`

### <a name="write_db/0"></a>`write_db/0`

Writes knowledge base (implementing matching DB protocol) to a file whose name appends _db to the file name.

* compilation flags: `static`
* mode - number of proofs:
  * `write_db` - `one`

### <a name="create_entities/0"></a>`create_entities/0`

Dynamically creates a PLP, a DB Protocol and a knowledge base.

* compilation flags: `static`
* mode - number of proofs:
  * `create_entities` - `one`
* see also:
  * [`create_plp/0`](#create_plp/0)
  * [`create_dbprotocol/0`](#create_dbprotocol/0)
  * [`create_db/0`](#create_db/0)

### <a name="write_entities/0"></a>`write_entities/0`

Writes  a PLP, a DB Protocol and a knowledge base to file.

* compilation flags: `static`
* mode - number of proofs:
  * `write_entities` - `one`
* see also:
  * [`write_plp/0`](#write_plp/0)
  * [`write_dbprotocol/0`](#write_dbprotocol/0)
  * [`write_db/0`](#write_db/0)

## Protected predicates

### <a name="plp_from_file/2"></a>`plp_from_file/2`
* compilation flags: `static`

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

* [`parserp`](parserp_0.md)

-------------------------------------------------------------------------------
