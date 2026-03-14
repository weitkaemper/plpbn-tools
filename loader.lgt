:- object(loader).
:- info([comment is 'Loader for the PLP-BN tools.']).

:- initialization(logtalk_load([writerp, graphp, symm_graphp, cond_graphp, plpp, bnp, plp_dsp, lpmlnp, types(loader), grammars(loader), reader(loader), os(loader), term_io(loader), format(loader), meta(loader), strings(loader), term_reader, entity_writer_util, plpc, plp_dsc,  parserp, plp, plp_ds, scc_factors, graph, graph_psymm, graph_csymm, oriented, lewis_cf, problog_dcg, dseparation, subprogram, causal_bn])).
:- end_object.
