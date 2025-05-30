

:- object(term_reader).

:- public(read_from_codes/2).


% main predicates

:- if(current_logtalk_flag(prolog_dialect, xsb)).
read_from_codes(Codes, Term) :-
		open(atom(Codes),read, Input),
		catch(read_term(Input, Term, []), Error, (close(Input),throw(Error))),
		close(Input).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
read_from_codes(Codes, Term) :-
		read_term_from_atom(Codes, Term, []).
:- elif(current_logtalk_flag(prolog_dialect, yap)).
read_from_codes(Codes, Term) :-
		read_term_from_atomic(Codes, Term, []).
:- else.
read_from_codes(Codes,Term) :-
		term_io::read_from_codes(Codes,Term).
:- endif.
:- end_object.














