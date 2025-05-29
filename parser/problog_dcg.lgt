:- object(problog_dcg).

:- public(plp_rules/2).

:- uses(blank_grammars(codes),[blank//0, blanks//0]).
:- uses(number_grammars(codes),[float//1]).
:- uses(term_reader,[read_from_codes/2]).

:- if(current_logtalk_flag(prolog_dialect, xsb)).
:- use_module(basics,[append/3]).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
:- use_module(library(lists),[append/3]).
:- endif.

%:- table plp_rules/2.

plp_rules(Rules, Codes) :-
    phrase(plp_rules(Rules), Codes).


% DCG rules
plp_rules([]) --> [].
plp_rules(Rules) -->
    blank, !,
    plp_rules(Rules).
plp_rules(Rules) -->
    comment, !,
    plp_rules(Rules).
plp_rules([probrule(H, P, B)|Rules]) -->
    plp_rule(H, P, B), !,
    plp_rules(Rules).


plp_rule(Head, Prob, Body) -->
    float(Prob),
	blanks,
    "::",
    !,
    blanks,
    term_as_codes(Clause),
    !,
    {parse_clause(Clause,Head,Body)}.




term_as_codes([D]) -->
    [D],
    { is_term_delimiter(D)}.

term_as_codes([C|Cs]) -->
    [C],
    { \+ is_term_delimiter(C) },
    term_as_codes(Cs).

comment -->
    "%",
    comment_line,
    newline_or_eos.

comment_line -->
    [C], { C =\= 0'\n, C =\= 0'\r }, !,
    comment_line.
comment_line --> [].

newline_or_eos --> "\n", !.
newline_or_eos --> "\r\n", !.
newline_or_eos --> eos.

eos([], []).  % End of stream

parse_clause(Clause, Head, Body) :-
    read_from_codes(Clause, (Head :- BodyC)),
    !,
    conj_to_list(BodyC,Body).

parse_clause(Clause, Head, []) :-
    read_from_codes(Clause,Head).


is_term_delimiter(0'.).  % "."


conj_to_list(','(A, B), [A|B1]) :- !,
	conj_to_list(B, B1).
conj_to_list(A, [A]).



:- end_object.


:- object(problog_dcg(_File_), extends(problog_dcg), implements(plpp)).

:- public([create_plp/1, write_plp/0]).

:- uses(reader,[file_to_codes/2]).
:- uses(os, [decompose_file_name/4]).

:- if(current_logtalk_flag(prolog_dialect, xsb)).
:- use_module(basics,[member/2]).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
:- use_module(library(lists),[member/2]).
:- endif.


%:- table plp_from_file/1.

probrule(H,P,B) :-
    plp_from_file(Rules),
    member(probrule(H,P,B), Rules).
% Top-level parser: parses a list of probrule(Head,Prob,Body)

write_plp :-
    decompose_file_name(_File_, _, Name, _),
    plp_from_file(Rules),
    object_writer::write_object(Name, [implements(plpp)], [], Rules).

% Load file and parse it into rules
plp_from_file(Rules) :-
    file_to_codes(_File_, Codes),
    ^^plp_rules(Rules, Codes).

:- end_object.










