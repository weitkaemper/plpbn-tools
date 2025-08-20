
-------------------------------------------------------------------------------
# protocol: `bnp`

Protocol for Bayesian networks.

* availability: `built_in`

* compilation flags: `static`

* extends:
  * `public` [`graphp`](graphp_0.md)

## Inherited public predicates

[`edge/2`](graphp_0.md)  [`node/1`](graphp_0.md)  

## Public predicates

### <a name="cpt/3"></a>`cpt/3`

The conditional probability table.

* compilation flags: `static`
* template: `cpt(child,parent valuation,probability)`
* mode - number of proofs:
  * `cpt(+term,+list(pair(term,boolean)),-between(float,0,1))` - `zero_or_one`
* remarks:
  * Implementation notes: An implementation of this protocol may expect parent valuations to be sorted according to the standard order of terms, and is not required to deal with unbound first or second argument. That way, Bayesian networks can be specified either by simply writing a list of one line per (ordered) parent valuation or by giving a more general predicate that computes a probability given some input.

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

(none)

## See also

(none)


-------------------------------------------------------------------------------
