:- protocol(writerp).
:- info([comment is 'A protocol designed for classes whose instantiations can write to file and create objects.']).

:- public(write_entity/1).
:- mode(write_entity(+atom),one).
:- info(write_entity/1, [
						 comment is 'Writes a flat version of the entity to file.',
						 remarks is ['Explanation' - 'Designed to be implemented by classes associated with the protocols for the main types of entity, such as plp or plp_ds, although it can also be meaningfully overwritten by individual implementations. This predicate writes a flat version of the entity to file, with facts for all the predicates declared in the associated protocol.'],
						 arguments is [identifier - 'used together with the .lgt ending to form the file name and as the name of the object written into the file.']
						]).
:- public(create_entity/1).
:- mode(create_entity(+atom),one).
:- info(create_entity/1, [
						 comment is 'Creates a flat version of the entitic as a dynamic object.',
						 remarks is ['Explanation' - 'Designed to be implemented by classes associated with the protocols for the main types of entity, such as plp or plp_ds, although it can also be meaningfully overwritten by individual implementations. This predicate creates a flat version of the entity as a dynamic object, with facts for all the predicates declared in the associated protocol.'],
						 arguments is [identifier - 'used as the name of the object written into the file.']
						]).


:- end_protocol.
