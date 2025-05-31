:- object(problog_dcg, implements(parserp)).

:- uses(blank_grammars(codes),[blank//0, blanks//0]).
:- uses(number_grammars(codes),[float//1]).
:- uses(term_reader,[read_from_codes/2]).
:- uses(list,[append/3]).

:- table plp_rules/3.

plp_rules(Codes,ProbRules,DetRules) :-
    phrase(plp_rules(ProbRules,DetRules),Codes).

% DCG rules
plp_rules([],[]) --> [].
plp_rules(PRules,DRules) -->
    blank, !,
    plp_rules(PRules,DRules).
plp_rules(PRules,DRules) -->
    comment, !,
    plp_rules(PRules,DRules).
plp_rules([probrule(H, P, B)|PRules],DRules) -->
    plp_rule(H, P, B), !,
    plp_rules(PRules,DRules).
plp_rules(PRules,[Clause|DRules]) -->
    det_rule(Clause), !,
    plp_rules(PRules,DRules).


plp_rule(Head, Prob, Body) -->
    float(Prob),
	blanks,
    "::",
    !,
    blanks,
    term_as_codes(Clause),
    !,
    {parse_clause(Clause,Head,Body)}.

det_rule(Clause) -->
    term_as_codes(RawClause),
    !,
    {read_from_codes(RawClause,Clause)}.

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












