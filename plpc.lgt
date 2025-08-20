:- object(plpc, implements([writerp,plpp]), instantiates(plpc)).
:- info([comment is 'Utility class for probabilistic logic programs in the probabilistic rule representation.']).

:- uses(entity_writer_util,[write_flat/3,create_flat/3]).

create_entity(Name) :-
    self(Self),
    create_flat(Self, plpp, Name).

write_entity(Name) :-
    self(Self),
    write_flat(Self, plpp, Name).



probrule(_,_,_) :-
	existence_error(procedure,probrule/3).

:- end_object.
