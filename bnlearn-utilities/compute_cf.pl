%#!/usr/bin/swilgt

:- if((current_prolog_flag(dialect, swi), \+current_predicate(current_logtalk_flag/2), pack_property(logtalk,_))).
:- use_module(library(logtalk)).
:- endif.
:- if((current_prolog_flag(dialect, swi), \+current_predicate(current_logtalk_flag/2), \+pack_property(logtalk,_))).
:- pack_install(logtalk).
:- use_module(library(logtalk)).
:- endif.

convert(BNFile,PLP) :-
    set_logtalk_flag(report,off),
    logtalk_load(['../loader']),
    logtalk_load(BNFile),
    os::absolute_file_name(BNFile,BNFilePath),
    object_property(BN,file(BNFilePath)),
    lewis_cf(BN)::write_problog(PLP),
    halt.


convert :-
    set_logtalk_flag(report,off),
    logtalk_load(os(loader)),
    os::command_line_arguments([BNFile,PLP]),
    convert(BNFile,PLP).







