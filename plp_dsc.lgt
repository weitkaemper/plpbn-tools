:- object(plp_dsc, implements([writerp, plp_dsp]), instantiates(plp_dsc)).
:- info([comment is 'Utility class for probabilistic logic programs in the distribution semantics.']).

:- public(write_problog/1).
:- mode(write_problog(+atom),one).
:- info(write_problog/1, [
						 comment is 'Write PLP to a ProbLog-compatible file.',
						 remarks is [explanation - 'Writes PLP to a file ending in .plp that can be used as imput by PLP systems that can read ProbLog notation. This includes cplint, ProbLog 2 and the Counterfactuals Python package.'],
						 arguments is [identifier - 'Identifier, from which the file name is obtained by appending the .plp file ending.']]).

:- uses(entity_writer_util,[write_object/4, write_clauses/2,listbodies_to_clauses/2,write_probfacts/2, write_flat/3, create_flat/3]).

create_entity(Name) :-
	self(Self),
	create_flat(Self,plp_dsp,Name).

write_entity(Name) :-
	self(Self),
	write_flat(Self,plp_dsp,Name).

write_problog(Identifier) :-
        atom_concat(Identifier, '.plp', Filename),
        open(Filename, write, Stream),
        findall((Prob :: Fact),(::probfact(Fact,Prob)),Probfacts),
        findall((Head :- Body),(::detrule(Head,Body)),Detrules),
        listbodies_to_clauses(Detrules,Clauses),
        write_clauses(Stream,Clauses),
        nl(Stream),
        write_probfacts(Stream,Probfacts),
        close(Stream).


probfact(_,_) :-
	existence_error(procedure,probfact/2).
detrule(_,_) :-
	existence_error(procedure,detrule/2).

:- end_object.
