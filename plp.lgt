:- object(plp(_Parser_,_File_), implements(plpp)).
% _Parses_ implements parserp, _File_ is an atom.

:- public([create_plp/0, write_plp/0, create_dbprotocol/0, write_dbprotocol/0, create_db/0, write_db/0, create_entities/0, write_entities/0]).

:- uses(reader,[file_to_codes/2]).
:- uses(os, [decompose_file_name/4]).

:- if(current_logtalk_flag(prolog_dialect, xsb)).
:- use_module(basics,[member/2]).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
:- use_module(library(lists),[member/2]).
:- endif.


:- table plp_from_file/2.

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
    entity_writer::write_object(Name, [implements(plpp)], [], PRules).

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
	entity_writer::write_protocol(PName,[],Declarations).

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
	entity_writer::write_object(DBName, [implements(PName)], [], DRules).

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
	entity_writer::write_entities(Name,[object(Name, [implements(plpp)], [], PRules), protocol(PName,[],Declarations), object(DBName, [implements(PName)], [], DRules)]).

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


