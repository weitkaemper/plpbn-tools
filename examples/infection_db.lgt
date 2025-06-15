:- object(infection_db, implements(infection_dbp)).

person(ann).
person(max).

time(1).
time(2).
time(3).
time(4).

time_step(X,Y) :-
	time(X),
	Y is X + 1,
	time(Y).

:- end_object.

:- object(infection_db_dir, extends(infection_db)).

:- public(direction/2).

direction(X,Y) :-
	number(X),
	number(Y),
	X < Y.

:- end_object.
