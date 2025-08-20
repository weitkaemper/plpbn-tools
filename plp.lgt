:- object(plp(_Parser_,_File_), instantiates(plpc)).
% _Parses_ implements parserp, _File_ is an atom.
:- public([create_plp/0, write_plp/0, create_dbprotocol/0, write_dbprotocol/0, create_db/0, write_db/0, create_entities/0, write_entities/0]).
:- protected(plp_from_file/2).


:- uses(reader,[file_to_codes/2]).
:- uses(os, [decompose_file_name/4]).
:- uses(list, [member/2]).

:- if(current_logtalk_flag(tabling,supported)).
:- table plp_from_file/2.
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


