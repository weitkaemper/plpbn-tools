The PLP-BN tools are an extensible set of tools designed to relate probabilistic logic programming and Bayesian networks. 

In order to enhance modularity and extensibility and allow for easier porting between Prolog engines, they are written in Logtalk rather than in plain Prolog. 
One can find a description of Logtalk along with tutorials and handbooks at [the official Logtalk website](www.logtalk.org).  

Probabilistic logic programs are represented as sets of probabilistic rules of the form `probrule(Head,Probability,Body)`. 
Facts are stored in a (deductive) *database*, which provides external predicates for the probabilistic logic program. 

The predicates that are to be supplied from a database should be specified in a protocol specific to the probabilistic logic program; see files `cora.lgt` (contains program and protocol) and `cora_db.lgt` for a complete example.  

## Usage
The core tools are loaded by calling `{loader}`. To use the parser, call `{parser_loader}`. The supplied examples can be called using `{example_loader}`.   

To compute the orientable edges of a graph `test1` according to the PC algorithm, call `oriented(test1)::edge(X,Y)` (returns all orientable edges on backtracking).

To compute the ground graph arising from a relational probabilistic logic program `cora` and database `cora_db`, call `graph(cora,cora_db)::edge(X,Y)` (returns all edges on backtracking).

To compute the probabilistic logic program in our internal format from a (simple) Problog program file `problog_test.plp` contained in your current directory, call `plp(problog_dcg,'problog_test.plp')::probrule(Head, Prob, Body)` (returns all probabilistic rules on backtracking).

`plp(problog_dcg,'problog_test.plp')::create_entities` creates dynamic objects for the plp, the corresponding database protocol and the concrete database;
`plp(problog_dcg,'problog_test.plp')::write_entities` writes those to a file called `problog_test.lgt`. 


Parametric objects can be combined freely; for instance, `oriented(graph(cora,cora_db))::edge(X,Y)` orients the edges induced by  `cora` and `cora_db`.   

## Protocols 

### Protocols for general use 
`graphp`: Declares `edge/2` as an arc relation in a graph.

`plpp`: Declares `probrule/3` representing probabilistic rules.  

`parserp`: Declares plp_rules/3, which takes a list of character codes as input and returns both probabilistic and deterministic rules encoded therein.

### Protocols specifically for graphs arising from grounding relational programs 
`cond_graphp`: Extends `graphp` and declares `edge/3`, which tracks a condition leading to the arc in its third argument.

`symm_graphp`: Extends `graphp` and declares `symmetry(+term, +term, ?term, ?term)`, which states that the direction of the edge between the first and second argument is the same as that of the edge between the third and fourth argument. 

## Objects 

### Core objects 

`oriented(Graph)`: Parametric object which takes a graph (implementing `graphp`) as a parameter and itself implements `graphp`. It returns only those edges which can be firmly oriented according to the rules of the PC-algorithm. If the input graph provides a predicate `oriented_edge/2`, it takes those orientations as given, and if the input graph implements `symm_graphp`, it uses those symmetries to orient additional edges.   

`graph(PLP,DB)`: Parametric object which takes a probabilistic logic program (implementing `plpp`) and a corresponding database as parameters and implements `cond_graphp`. It computes the ground graph of PLP when instantiated with DB, optionally labelled with the conditions that have been met for the edge to exist in the ground graph. 

`graph_psymm(PLP,DB)`: Parametric object extending `graph(PLP,DB)` and implementing `symm_graphp`. It defines two edges as symmetric if their respective endpoints share the same predicate functors.

`graph_csymm(PLP,DB)`: Parametric object extending `graph_psymm(PLP,DB)` and overriding symmetry/4. In addition to the conditions of `graph_psymm(PLP,DB)`, it also requires the conditions to share the same functors. 

`plp(_Parser, _File_)` : A parametric object which takes a parser and a file as a parameter and implements `plpp`. It also provides various predicates for creating the plp, the corresponding database protocol and the concrete database as dynamic entities, and for writing those entities to files. 

### General utilities 
`term_reader`: Uses conditional compilation to provide a more robust alternative to the LogTalk library predicate `term_io::read_from_codes/2` with SWI, XSB and YAP, while falling back to the library predicate with other backends. 

`entity_writer`: Provides predicates to write LogTalk entities to file, mirroring LogTalk built-ins for creating dynamic entities such as `create_object/4` and `create_protocol/3`. 

### Parsers 
`problog_dcg`: A rudimentary ProbLog parser, it reads a file in ProbLog notation which consists only of clauses of the form `P :: H :- B` with a float `P`, a clause head `H` and a clause body `B`. It does deal with formatting as well as comments starting with `%` and ending in a newline, but not with more sophisticated constructs. 


