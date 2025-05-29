:- object(uwcse1_db, implements(uwcse1_dbp)).

student(harry).
professor(ben).
project(pr1, harry).
project(pr1, ben).
project(pr2, harry).
project(pr2, ben).
ta(c1, harry).
ta(c2, harry).
taughtby(c1, ben).
taughtby(c2, ben).
publication(p1, harry, pr1).
publication(p1, ben, pr1).
publication(p2, harry, pr1).
publication(p2, ben, pr1).
publication(p3, harry, pr2).
publication(p3, ben, pr2).
publication(p4, harry, pr2).
publication(p4, ben, pr2).

:- end_object.
