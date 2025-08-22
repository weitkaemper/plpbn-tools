
-------------------------------------------------------------------------------
# protocol: `writerp`

A protocol designed for classes whose instantiations can write to file and create objects.

* availability: `built_in`

* compilation flags: `static`

* dependencies:
  (none)


## Inherited public predicates

(none)

## Public predicates

### <a name="write_entity/1"></a>`write_entity/1`

Writes a flat version of the entity to file.

* compilation flags: `static`
* template: `write_entity(identifier)`
  * `identifier` - used together with the .lgt ending to form the file name and as the name of the object written into the file.
* mode - number of proofs:
  * `write_entity(+atom)` - `one`
* remarks:
  * Explanation: Designed to be implemented by classes associated with the protocols for the main types of entity, such as plp or plp_ds, although it can also be meaningfully overwritten by individual implementations. This predicate writes a flat version of the entity to file, with facts for all the predicates declared in the associated protocol.

### <a name="create_entity/1"></a>`create_entity/1`

Creates a flat version of the entitic as a dynamic object.

* compilation flags: `static`
* template: `create_entity(identifier)`
  * `identifier` - used as the name of the object written into the file.
* mode - number of proofs:
  * `create_entity(+atom)` - `one`
* remarks:
  * Explanation: Designed to be implemented by classes associated with the protocols for the main types of entity, such as plp or plp_ds, although it can also be meaningfully overwritten by individual implementations. This predicate creates a flat version of the entity as a dynamic object, with facts for all the predicates declared in the associated protocol.

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
