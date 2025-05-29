:- object(uwcse1, implements(plpp)).

probrule(advisedby(A,B),0.3,[student(A), professor(B), project(C, A),
project(C, B), r11(A, B, C)]).
probrule(advisedby(A,B),0.3,[student(A), professor(B), ta(C, A),
taughtby(C, B)]).
probrule(r11(A, B, C),0.3,[publication(D, A, C), publication(D,B, C)]).

:- end_object.

:- protocol(uwcse1_dbp).

:- public(student/1).
:- public(professor/1).
:- public(project/2).
:- public(ta/2).
:- public(taughtby/2).
:- public(publication/3).


:- end_protocol.

