:- object(cora, implements(plpp)).

probrule(samebib(B,C),0.3,[author(B,D),author(C,E),sameauthor(D,E)]).
probrule(samebib(B,C),0.3,[title(B,D),title(C,E),sameatitle(D,E)]).
probrule(samebib(B,C),0.3,[venue(B,D),venue(C,E),samevenue(D,E)]).
probrule(samevenue(A,B),0.3,[haswordvenue(A,C),haswordvenue(B,C)]).
probrule(sameatitle(A,B),0.3,[haswordtitle(A,C),haswordtitle(B,C)]).
probrule(sameauthor(A,B),0.3,[haswordauthor(A,C),haswordauthor(B,C)]).

:- end_object.

:- protocol(cora_dbp).

:- public(author/2).
:- public(title/2).
:- public(venue/2).
:- public(haswordvenue/2).
:- public(haswordtitle/2).
:- public(haswordauthor/2).


:- end_protocol.

