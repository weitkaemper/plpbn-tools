:- object(ex_lpmln_2, implements(lpmlnp)).

%weightrule(b,0.5,[]).
%weightrule(a,1,[]).
weightrule(b,1,[\+ a]).
weightrule(a,0,[\+ b]).
:- end_object.
