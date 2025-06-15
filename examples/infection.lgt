:- object(infection, implements(plpp)).

probrule(ill(X,T),0.3,[person(X), time(T), \+ resistant(X,T)]).
probrule(resistant(X,T),0.8,[person(X), time_step(T1,T),ill(X,T1)]).

:- end_object.

:- protocol(infection_dbp).

:- public(person/1).
:- public(time/1).
:- public(time_step/2).


:- end_protocol.

