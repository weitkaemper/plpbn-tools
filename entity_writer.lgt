:- object(entity_writer).
:- public([write_flat/2, write_object/4, write_object/5, write_protocol/4, write_protocol/3, write_entities/2]).

:- uses(format,[format/3]).
:- uses(list,[length/2]).

write_flat(Object,Identifier) :-
        findall(implements(Protocol),implements_protocol(Object, Protocol),Relations),
        findall(Fact,
                (   Object::current_predicate(Predicate/Arity),
                    length(L,Arity),
                    Fact =.. [Predicate|L],
                    Object::Fact
                ),
                Facts),
        write_object(Identifier,Relations,[],Facts).


write_object(Identifier, Relations, Directives, Clauses) :-
        atom_concat(Identifier, '.lgt', Filename),
        write_object(Filename, Identifier, Relations, Directives, Clauses).

write_object(Filename,Identifier, Relations, Directives, Clauses) :-
        open(Filename, write, Stream),
        write_object_core(Stream,Identifier, Relations, Directives, Clauses),
        close(Stream).

write_object_core(Stream,Identifier, Relations, Directives, Clauses) :-
        write_object_header(Stream, Identifier, Relations),
        write_directives(Stream, Directives),
        write_clauses(Stream, Clauses),
        write(Stream, ':- end_object.'),
        nl(Stream).

write_protocol(Identifier, Relations, Directives) :-
        atom_concat(Identifier, '.lgt', Filename),
        write_protocol(Filename, Identifier, Relations, Directives).

write_protocol(Filename,Identifier, Relations, Directives) :-
        open(Filename, write, Stream),
        write_protocol_core(Stream,Identifier, Relations, Directives),
        close(Stream).

write_protocol_core(Stream,Identifier, Relations, Directives) :-
        write_protocol_header(Stream, Identifier, Relations),
        write_directives(Stream, Directives),
        write(Stream, ':- end_protocol.'),
        nl(Stream).


write_entities(Filename, Entities) :-
        open(Filename, write, Stream),
        write_entities_core(Stream, Entities),
        close(Stream).

write_entities_core(_,[]).
write_entities_core(Stream,[object(Identifier, Relations, Directives, Clauses)|Objects]) :-
        write_object_core(Stream,Identifier, Relations, Directives, Clauses),
        nl(Stream),
        write_entities_core(Stream,Objects).
write_entities_core(Stream,[protocol(Identifier, Relations, Directives)|Objects]) :-
        write_protocol_core(Stream,Identifier, Relations, Directives),
        nl(Stream),
        write_entities_core(Stream,Objects).


% Header with optional relations
write_protocol_header(Stream, Identifier, Relations) :-
        format(Stream, ':- protocol(~w', [Identifier]),
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
