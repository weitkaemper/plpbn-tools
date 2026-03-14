:- object(plpc, implements([writerp,plpp]), instantiates(plpc)).
:- info([comment is 'Utility class for probabilistic logic programs in the probabilistic rule representation.']).

:- public(write_problog/1).
:- mode(write_problog(+atom),one).
:- info(write_problog/1, [
						 comment is 'Write PLP to a ProbLog-compatible file.',
						 remarks is [explanation - 'Writes PLP to a file ending in .plp that can be used as input to PLP systems that can read ProbLog notation. This includes cplint, ProbLog 2 and the Counterfactuals Python package.'],
						 arguments is [identifier - 'Identifier, from which the file name is obtained by appending the .plp file ending.']]).

:- public(write_plingo_problog/1).
:- mode(write_plingo_problog(+atom),one).
:- info(write_plingo_problog/1, [
						 comment is 'Write PLP to a file compatible with the ProbLog frontend of plingo.',
						 remarks is [explanation - 'Writes PLP to a file ending in .plp that can be used as input to potasscos plingo system with the ProbLog frontend'],
						 arguments is [identifier - 'Identifier, from which the file name is obtained by appending the .plp file ending.']]).


:- uses(entity_writer_util,[write_clauses/2,listbodies_to_clauses/2, write_plingo_problog_probrules/2, write_flat/3, create_flat/3, write_probfacts/2, write_plingo_problog_probfacts/2]).
:- uses(string(atom), [atomics_to_string/2]).


create_entity(Name) :-
    self(Self),
    create_flat(Self, plpp, Name).

write_entity(Name) :-
    self(Self),
    write_flat(Self, plpp, Name).

write_problog(Identifier) :-
    atom_concat(Identifier, '.plp', Filename),
    open(Filename, write, Stream),
    findall((Prob :: Head :- Body),(::probrule(Head,Prob,Body), Body \= []),Probrules),
    findall((Prob :: Head),(::probrule(Head,Prob,[])),Probfacts),
    listbodies_to_clauses(Probrules,Clauses),
    write_clauses(Stream,Clauses),
    nl(Stream),
    write_probfacts(Stream,Probfacts),
    close(Stream).

write_plingo_problog(Identifier) :-
    atom_concat(Identifier, '.plp', Filename),
    open(Filename, write, Stream),
    findall(newclause(Head,ProbString,Body),(::probrule(Head,Prob,Body), Body \= [], atomics_to_string(['("',Prob,'")'],ProbString)),Probrules),
    write_plingo_problog_probrules(Stream,Probrules),
    nl(Stream),
    findall(Fact-ProbString,(::probrule(Fact,Prob,[]), atomics_to_string(['("',Prob,'")'],ProbString)),Probfacts),
    write_plingo_problog_probfacts(Stream,Probfacts),
    close(Stream).


probrule(_,_,_) :-
	existence_error(procedure,probrule/3).

:- end_object.
