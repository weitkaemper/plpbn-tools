%#!/usr/bin/swilgt

%:- initialization(convert).

convert :-
    set_logtalk_flag(report,off),
    logtalk_load(['../loader','../parser_loader']),
    os::command_line_arguments([BNFile,PLP]),
    logtalk_load(BNFile),
    os::absolute_file_name(BNFile,BNFilePath),
    object_property(BN,file(BNFilePath)),
    entity_writer::write_problog(lewis_cf(BN),PLP),
    user:halt(0).
