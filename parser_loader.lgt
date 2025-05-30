:- object(parser_loader).

:- initialization(logtalk_load([grammars(loader), reader(loader), os(loader), term_io(loader), term_reader, format(loader), entity_writer, parserp, plp, problog_dcg])).

:- end_object.
