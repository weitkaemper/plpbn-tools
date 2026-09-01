:- object(ex_cyclic_plpds_2, instantiates(plp_dsc)).
probfact(u,0.5).

detrule(b,[not(a)]).
detrule(a,[not(b)]).
:- end_object.
