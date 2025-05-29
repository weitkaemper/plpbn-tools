:- object(uwcse1_db2, implements(uwcse1_dbp)).

student(harry).
student(mary).
student(phil).
professor(ben).
professor(stacy).
project(pr1, harry).
project(pr1, ben).
project(pr2, harry).
project(pr2, ben).
project(pr2, phil).
project(pr3, stacy).
project(pr3, harry).
project(pr3, phil).
project(pr4, mary).
project(pr4, stacy).
ta(c1, harry).
ta(c2, harry).
ta(c3, mary).
ta(c1, phil).
taughtby(c1, ben).
taughtby(c2, ben).
taughtby(c3, stacy).
publication(p1, harry , pr1).
publication(p1, ben, pr1).
publication(p2, harry , pr2).
publication(p2, ben, pr2).
publication(p2, phil, pr2).
publication(p3, phil , pr3).
publication(p3, harry , pr3).
publication(p3, stacy, pr3).
publication(p4, phil , pr4).
publication(p4, stacy, pr4).

:- end_object.


