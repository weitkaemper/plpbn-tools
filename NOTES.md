The PLP-BN tools are an extensible set of tools designed to relate probabilistic logic programming and Bayesian networks. 

In order to enhance modularity and extensibility and allow for easier porting between Prolog engines, they are written in Logtalk rather than in plain Prolog. 
One can find a description of Logtalk along with tutorials and handbooks at [the official Logtalk website](www.logtalk.org).  

Probabilistic logic programs are represented as sets of probabilistic rules of the form `probrule(Head,Probability,Body)`. 
Facts are stored in a (deductive) *database*, which provides external predicates for the probabilistic logic program. 

== Protocols ==

=== Protocols for general use ===
`graphp`: Declares `edge/2` as an arc relation in a graph.

`plpp`: Declares `probrule/3` representing probabilistic rules.  

=== Protocols specifically for graphs arising from grounding relational programs ===
`cond_graphp`: Extends `graphp` and declares `edge/3`, which tracks a condition leading to the arc in its third argument.

`symm_graphp`: Extends `graphp` and declares `symmetry(+term, +term, ?term, ?term)`, which states that the direction of the edge between the first and second argument is the same as that of the edge between the third and fourth argument. 

== Objects ==

=== Core objects ===

`oriented(Graph)`: Parametric object which takes a graph (implementing `graphp`) as a parameter and itself implements `graphp`. It returns only those edges which can be firmly oriented according to the rules of the PC-algorithm. If the input graph provides a predicate `oriented_edge/2`, it takes those orientations as given, and if the input graph implements `symm_graphp`, it uses those symmetries to orient additional edges.   

`graph(PLP,DB)`: Parametric object which takes a probabilistic logic program (implementing `plpp`) and a corresponding database as parameters and implements `cond_graphp`. It computes the ground graph of PLP when instantiated with DB, optionally labelled with the conditions that have been met for the edge to exist in the ground graph. 

`graph_psymm(PLP,DB)`: Parametric object extending `graph(PLP,DB)` and implementing `symm_graphp`. It defines two edges as symmetric if their respective endpoints share the same predicate functors.

`graph_csymm(PLP,DB)`: Parametric object extending `graph_psymm(PLP,DB)` and overriding symmetry/4. In addition to the conditions of `graph_psymm(PLP,DB)`, it also requires the conditions to share the same functors. 

=== Parsers ===

`problog_dcg(_File_)` \[contained in problog_dcg.lgt]: A parametric object which takes a file as a parameter and implements `plpp`. A rudimentary ProbLog parser, it reads a file in ProbLog notation which consists only of clauses of the form `P :: H :- B` with a float `P`, a clause head `H` and a clause body `B`. It does deal with formatting as well as comments starting with `%` and ending in a newline, but not with more sophisticated constructs.

=== General utilities ===
`term_reader`: Uses conditional compilation to provide a more robust alternative to the LogTalk library predicate `term_io::read_from_codes/2` with SWI, XSB and YAP, while falling back to the library predicate with other backends. 

`entity_writer`: Provides predicates to write LogTalk entities to file, mirroring LogTalk built-ins for creating dynamic entities such as `create_object/4` and `create_protocol/3`. 

=== Specific utilities ===
`problog_dcg`: The underlying definite clause grammar supporting the parsing in `problog_dcg(_File_)`. 

