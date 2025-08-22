
-------------------------------------------------------------------------------
# object: `problog_dcg`

A parser for ProbLog files.

* availability: `built_in`

* compilation flags: `static, context_switching_calls`

* implements:
  * `public` [`parserp`](parserp_0.md)
* uses:
  * [`blank_grammars(Format)`](blank_grammars_1.md)
  * [`list`](list_0.md)
  * [`number_grammars(Format)`](number_grammars_1.md)
  * [`term_reader`](term_reader_0.md)

## Inherited public predicates

[`plp_rules/3`](parserp_0.md)  

## Public predicates

(no local declarations; see entity ancestors if any)

## Protected predicates

(no local declarations; see entity ancestors if any)

## Private predicates

(no local declarations; see entity ancestors if any)

## Operators

(none)

## Remarks

* Scope and limitations: This rudimentary ProbLog parser reads a file in ProbLog notation which consists only of ordinary Prolog clauses and of clauses of the form `P :: H :- B` with a float `P`, a clause head `H` and a clause body `B`. It does deal with formatting as well as comments starting with `%` and ending in a newline, but not with more sophisticated constructs.

## See also

(none)


-------------------------------------------------------------------------------
