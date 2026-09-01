:- object(bn_sprinkler, implements(bnp)).

node(cloudy).
node(sprinkler).
node(rain).
node(wet).

edge(cloudy,rain).
edge(cloudy,sprinkler).
edge(sprinkler,wet).
edge(rain,wet).

cpt(cloudy,[],0.5).
cpt(sprinkler,[cloudy-false],0.5).
cpt(sprinkler,[cloudy-true], 0.1).
cpt(rain,[cloudy-false],0.2).
cpt(rain,[cloudy-true],0.8).
cpt(wet,[rain-false,sprinkler-false],0.1).
cpt(wet,[rain-false,sprinkler-true],0.9).
cpt(wet,[rain-true,sprinkler-false],0.9).
cpt(wet,[rain-true,sprinkler-true],0.99).

:- end_object.

