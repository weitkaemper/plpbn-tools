:- object(object_writer).
:- public(write_object/4).

:- uses(format,[format/3]).

write_object(Identifier, Relations, Directives, Clauses) :-
        atom_concat(Identifier, '.lgt', Filename),
        open(Filename, write, Stream),
        write_object_header(Stream, Identifier, Relations),
        write_directives(Stream, Directives),
        write_clauses(Stream, Clauses),
        write(Stream, ':- end_object.'),
        nl(Stream),
        close(Stream).

% Header with optional relations
write_object_header(Stream, Identifier, Relations) :-
        format(Stream, ':- object(~w', [Identifier]),
        (   Relations == []
        ->  write(Stream, ').'),
            nl(Stream),
            nl(Stream)
        ;   write(Stream, ','),
            write_relations(Stream, Relations),
            write(Stream, ').'),
            nl(Stream),
            nl(Stream)
        ).

write_relations(_, []).
write_relations(Stream, [Relation|Rest]) :-
        write(Stream, '    '),
        write_term(Stream, Relation, [quoted(true)]),
        (Rest \= [] -> write(Stream, ','), nl(Stream) ; true),
        write_relations(Stream, Rest).

% Directives like public/1, dynamic/1
write_directives(_, []).
write_directives(Stream, [Directive|Rest]) :-
        write(Stream, ':- '),
        write_term(Stream, Directive, [quoted(true)]),
        write(Stream, '.'),
        nl(Stream),
        write_directives(Stream, Rest),
        (Rest == [] -> nl(Stream) ; true).

% Clause writer
write_clauses(_, []).
write_clauses(Stream, [Clause|Rest]) :-
        write_clause(Stream, Clause),
        write_clauses(Stream, Rest).

write_clause(Stream, (Head :- Body)) :-
        write_term(Stream, Head, [quoted(true)]),
        write(Stream, ' :-'),
        write_body(Stream, Body, 1),
        write(Stream, '.'),
        nl(Stream),
        nl(Stream).
write_clause(Stream, Fact) :-
        write_term(Stream, Fact, [quoted(true)]),
        write(Stream, '.'),
        nl(Stream),
        nl(Stream).

% Pretty printer for clause bodies
write_body(Stream, (A,B), Indent) :-
        nl(Stream),
        indent(Stream, Indent),
        write_term(Stream, A, [quoted(true)]),
        write(Stream, ','),
        write_body(Stream, B, Indent).
write_body(Stream, (A;B), Indent) :-
        nl(Stream),
        indent(Stream, Indent),
        write_term(Stream, (A;B), [quoted(true)]).
write_body(Stream, (A->B), Indent) :-
        nl(Stream),
        indent(Stream, Indent),
        write_term(Stream, (A->B), [quoted(true)]).
write_body(Stream, (\+ A), Indent) :-
        nl(Stream),
        indent(Stream, Indent),
        write(Stream, '\\+ '),
        write_term(Stream, A, [quoted(true)]).
write_body(Stream, A, Indent) :-
        nl(Stream),
        indent(Stream, Indent),
        write_term(Stream, A, [quoted(true)]).

indent(Stream, N) :-
        Spaces is N * 4,
        format(Stream, '~*t', [Spaces]).

:- end_object.
