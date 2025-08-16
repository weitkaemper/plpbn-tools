%#!/usr/bin/swilgt

%:- initialization(convert).
convert(BNFile,PLP) :-
    set_logtalk_flag(report,off),
    logtalk_load(['../loader','../parser_loader']),
    logtalk_load(BNFile),
    os::absolute_file_name(BNFile,BNFilePath),
    object_property(BN,file(BNFilePath)),
    entity_writer::write_problog(lewis_cf(BN),PLP),
    halt.


convert :-
    set_logtalk_flag(report,off),
    logtalk_load(os(loader)),
    os::command_line_arguments([BNFile,PLP]),
    convert(BNFile,PLP).
