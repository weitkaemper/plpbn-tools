:- object(plp(_Parser_,_File_), instantiates(plpc)).
:- info([comment is 'An object that extracts an internal probabilistic logic program representation and a database from a parsed probabilistic logic program.',
         parameters is [parser - 'A parser implementing parserp.',
                       file - 'A file descriptor (an atom) containing a probabilistic logic program to be parsed by the parser.'],
        see_also is [parserp]]).
% _Parses_ implements parserp, _File_ is an atom.
:- public([create_plp/0, write_plp/0, create_dbprotocol/0, write_dbprotocol/0, create_db/0, write_db/0, create_entities/0, write_entities/0]).
:- mode(create_plp, one).
:- mode(write_plp, one).
:- mode(create_dbprotocol, one).
:- mode(write_dbprotocol, one).
:- mode(create_db, one).
:- mode(write_db, one).
:- mode(create_entities, one).
:- mode(write_entities, one).

:- info(create_plp/0, [comment is 'Creates PLP (implementing plpp) as a dynamic object whose name matches the file name.']).
:- info(write_plp/0, [comment is 'Writes PLP (implementing plpp) to a file whose name matches the file name.']).
:- info(create_dbprotocol/0, [comment is 'Creates matching database protocol.',
                       remarks is [explanation - 'Creates a dynamic protocol to be implemented by the background knowledge bases for the PLP.']]).
:- info(write_dbprotocol/0, [comment is 'Writes matching database protocol to file.',
                       remarks is [explanation - 'Writes a dynamic protocol to be implemented by the background knowledge bases for the PLP. The file name is created by appending p to the file identifier.']]).
:- info(create_db/0, [comment is 'Creates knowledge base (implementing matching DB protocol) as a dynamic object whose name appends _db to the file name.']).
:- info(write_db/0, [comment is 'Writes knowledge base (implementing matching DB protocol) to a file whose name appends _db to the file name.']).
:- info(create_entities/0, [comment is 'Dynamically creates a PLP, a DB Protocol and a knowledge base.', see_also is [create_plp/0, create_dbprotocol/0,create_db/0]]).
:- info(write_entities/0, [comment is 'Writes  a PLP, a DB Protocol and a knowledge base to file.', see_also is [write_plp/0, write_dbprotocol/0, write_db/0]]).

:- protected(plp_from_file/2).


:- uses(reader,[file_to_codes/2]).
:- uses(os, [decompose_file_name/4]).
:- uses(list, [member/2]).

:- if(current_logtalk_flag(tabling,supported)).
:- table(plp_from_file/2).
:- endif.

probrule(H,P,B) :-
    plp_from_file(PRules,_),
    member(probrule(H,P,B), PRules).

create_plp :-
    decompose_file_name(_File_, _, Name, _),
    plp_from_file(PRules,_),
    create_object(Name, [implements(plpp)], [], PRules).

write_plp :-
    decompose_file_name(_File_, _, Name, _),
    plp_from_file(PRules,_),
    entity_writer_util::write_object(Name, [implements(plpp)], [], PRules).

create_dbprotocol :-
	decompose_file_name(_File_, _, Name, _),
	atom_concat(Name,p,PName),
	plp_from_file(_,DRules),
	defined_in(DRules,DFuncs),
	setof(public(Func), member(Func,DFuncs), Declarations),
	create_protocol(PName,[],Declarations).

write_dbprotocol :-
	decompose_file_name(_File_, _, Name, _),
	atom_concat(Name,p,PName),
	plp_from_file(_,DRules),
	defined_in(DRules,DFuncs),
	setof(public(Func), member(Func,DFuncs), Declarations),
	entity_writer_util::write_protocol(PName,[],Declarations).

create_db :-
	decompose_file_name(_File_, _, Name, _),
	atom_concat(Name,'_db',DBName),
	atom_concat(Name,p,PName),
	plp_from_file(_,DRules),
	create_object(DBName, [implements(PName)], [], DRules).

write_db :-
	decompose_file_name(_File_, _, Name, _),
	atom_concat(Name,'_db',DBName),
	atom_concat(Name,p,PName),
	plp_from_file(_,DRules),
	entity_writer_util::write_object(DBName, [implements(PName)], [], DRules).

create_entities :-
	create_plp,
	create_dbprotocol,
	create_db.

write_entities :-
	decompose_file_name(_File_, _, Name, _),
	atom_concat(Name,'_db',DBName),
	atom_concat(Name,p,PName),
	plp_from_file(PRules,DRules),
	defined_in(DRules,DFuncs),
	setof(public(Func), member(Func,DFuncs), Declarations),
	entity_writer_util::write_entities(Name,[object(Name, [implements(plpp)], [], PRules), protocol(PName,[],Declarations), object(DBName, [implements(PName)], [], DRules)]).


% Load file and parse it into rules
plp_from_file(PRules,DRules) :-
    file_to_codes(_File_, Codes),
    _Parser_::plp_rules(Codes,PRules,DRules).

defined_in([],[]).
defined_in([C|DRules],[HFunc/N|Heads]) :-
	C = (H :- _),
	functor(H,HFunc,N),
	defined_in(DRules,Heads).
defined_in([Fact|DRules], [FFunc/N|Heads]) :-
	Fact \= (_ :- _),
	functor(Fact,FFunc,N),
	defined_in(DRules,Heads).





:- end_object.


