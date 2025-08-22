The PLP-BN tools are an extensible set of tools designed to relate probabilistic logic programming and Bayesian networks.
The PLP-BN tools are written in tabled Logtalk. In order to run them, you need a copy of [Logtalk](www.logtalk.org),  and to make full use of all its features you also need a backend Prolog compiler which supports tabling. They have been tested using Logtalk 3.91.0 and both [SWI-Prolog](swi-prolog.org) 9.0.4 and [XSB](xsb.sourceforge.net) 5.1.


The API documentation maintained with `lgtdoc` can be found in the directory `xml_docs`; an entity diagram can be found in the directory `dot_dias`.

In order to enhance modularity and extensibility and allow for easier porting between Prolog engines, they are written in Logtalk rather than in plain Prolog.
One can find a description of Logtalk along with tutorials and handbooks at [the official Logtalk website](www.logtalk.org).

Probabilistic logic programs are represented as sets of probabilistic rules of the form `probrule(Head,Probability,Body)`.
Facts are stored in a (deductive) *database*, which provides external predicates for the probabilistic logic program.

The predicates that are to be supplied from a database should be specified in a protocol specific to the probabilistic logic program; see files `cora.lgt` (contains program and protocol) and `cora_db.lgt` for a complete example.

## Usage
The core tools are loaded by calling `{loader}`. To use the parser, call `{parser_loader}`. The supplied examples can be loaded using `{example_loader}`.

To compute the orientable edges of a graph `test1` according to the PC algorithm, call `oriented(test1)::edge(X,Y)` (returns all orientable edges on backtracking).
Symmetries are used whenever they are provided by the input graph; therefore, `oriented(graph(uwcse1,uwcse1_db2))::edge(X,Y)` orients a smaller number of edges than  `oriented(graph_psymm(uwcse1,uwcse1_db2))::edge(X,Y)`, which is able to orient the entire graph.

To compute the ground graph arising from a relational probabilistic logic program `cora` and database `cora_db`, call `graph(cora,cora_db)::edge(X,Y)` (returns all edges on backtracking).

To compute the probabilistic logic program in our internal probabilistic rules format from a (simple) Problog program file `problog_test.plp` contained in your current directory, call `plp(problog_dcg,'problog_test.plp')::probrule(Head, Prob, Body)` (returns all probabilistic rules on backtracking).

To compute a probabilistic logic program from a Bayesian network, use the object lewis_cf(_BN_) for a Bayesian network object _BN_. This probabilistic logic program has the additional property that its associated counterfactual worlds only differ minimally from the "real world" in a specific sense.

Parametric objects can be combined freely; for instance, `oriented(graph(cora,cora_db))::edge(X,Y)` orients the edges induced by  `cora` and `cora_db`.

To support working with Bayesian networks fitted using the popular `bnlearn` libraries in python and R, the `bnlearn_utlities` directory contains Python and R functions writing a Bayesian network to file as a Logtalk object.
This directory also contains a Prolog/Logtalk convenience script `compute_cf.pl`  to be used as a command line utility for writing a ProbLog program  (the input format for e.g. the What If? counterfactual solver) to file that corresponds to an input Bayesian network (as a Logtalk object), using `lewis_cf` (see above) for the actual computation.

The easiest way to use that script from scratch is to install SWI-Prolog (either from www.swi-prolog.org or from a package manager) and then to call
```
swipl -g convert compute_cf.pl Input.lgt Output
```
The first time of calling this script, if Logtalk is not yet installed, the SWI-Prolog interpreter should now prompt you for a directory for installing packs and for confirmation to install Logtalk as a SWI-Prolog pack.

After Logtalk has been successfully installed, conversion should proceed as normal.

If Logtalk has already been installed in the ordinary, backend-agnostic manner as detailed on www.logtalk.org, the script should be launched from Logtalk instead of from plain Prolog.

With SWI-Prolog as the back-end Prolog compiler it can be invoked as
```
swilgt -g convert compute_cf.pl Input.lgt Output
```

where Input.lgt is a logtalk object implementing `bnp` and the resulting ProbLog program is written to `Output.plp`.

If XSB is used as the back-end Prolog compiler, it can be invoked as
```
xsblgt -e "[compute_cf], convert('Input.lgt', Output)."
```
(note the period mark, the " and the ' in the command line flag).

