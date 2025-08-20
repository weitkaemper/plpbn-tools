:- protocol(bnp, extends(graphp)).
:- info([comment is 'Protocol for Bayesian networks.']).
% A conditional probability table cpt(Child,ParentVal,Prob).
:- public(cpt/3).
:- mode(cpt(+term,+list(pair(term,boolean)),-between(float,0,1)),zero_or_one).
:- info(cpt/3, [
			   comment is 'The conditional probability table.',
			   remarks is ['Implementation notes' - 'An implementation of this protocol may expect parent valuations to be sorted according to the standard order of terms, and is not required to deal with unbound first or second argument. That way, Bayesian networks can be specified either by simply writing a list of one line per (ordered) parent valuation or by giving a more general predicate that computes a probability given some input.'],
			  argnames is [child,'parent valuation', probability]]).
:- end_protocol.
