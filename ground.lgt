:- object(ground(_PLP_,_DB_), instantiates(plpc)).

probrule(H,P,B) :-
	_PLP_::probrule(H,P,Body),
	split_body(Body,B,C),
	dbcheck(C).

%-- Utilities --%


split_body([],[],[]).

split_body([A|Body], Int, Ext) :-
      ( functor(A,F,N),
		external(F,N)
      ->  Ext = [A|E],
          split_body(Body, Int, E)
      ;   Int = [A|I],
          split_body(Body, I, Ext)
      ).

external(F,N) :-
	functor(T,F,N),
	_DB_::predicate_property(T, _).

dbcheck([]).
dbcheck([H|C]) :-
	_DB_::H,
	dbcheck(C).

:- end_object.
