:- object(stratifier).

:- public([stratify/2,stratify/3]).

:- uses(list, [ member/2, select/3, max/2, sort/2]).
:- uses(meta, [map/3]).
:- uses(pairs,[keys/2 as pairs_keys/2, values/2 as pairs_values/2]).
:- uses(set,[as_set/2, union/3]).
:- uses(term,[subterm/2 as sub_term/2]).


stratify(Program,Strata, AscOrderedPreds) :-
        stratify(Program,Strata),
        sort(Strata,SortedStrata),
        pairs_values(SortedStrata,AscOrderedPreds).

stratify(Program, Strata) :-
        extract_all_predicates(Program, Preds),
        map(init_stratum, Preds, Strata0),
        fixpoint_stratify(Program, Strata0, Strata).

init_stratum(Pred, 0-Pred).

fixpoint_stratify(Program, StrataIn, StrataOut) :-
        update_strata(Program, StrataIn, StrataNext),
        (StrataIn == StrataNext ->
        StrataOut = StrataNext
        ;
        fixpoint_stratify(Program, StrataNext, StrataOut)
        ).

update_strata([], Strata, Strata).
update_strata([H-_-Bodies | Rest], StrataIn, StrataOut) :-
        max_required_stratum(Bodies, StrataIn, ReqStratum),
        get_stratum(H, StrataIn, Current),
        New is max(Current, ReqStratum),
        update_stratum_assoc(H, New, StrataIn, StrataNext),
        update_strata(Rest, StrataNext, StrataOut).

max_required_stratum([], _, 0).
max_required_stratum([not(Pred-_) | Rest], Strata, Max) :-
        get_stratum(Pred, Strata, S),
        R is S + 1,
        max_required_stratum(Rest, Strata, M),
        Max is max(R, M).
max_required_stratum([Pred-_ | Rest], Strata, Max) :-
        get_stratum(Pred, Strata, R),
        max_required_stratum(Rest, Strata, M),
        Max is max(R, M).

extract_all_predicates(Program, UniquePreds) :-
        pairs_keys(Program,Heads),
        pairs_keys(Heads,HeadPredList),
        as_set(HeadPredList,HeadPreds),
        pairs_values(Program,Bodies),
        setof(Pred,
            sub_term(Pred-_,Bodies),
                BodyPreds),
        union(HeadPreds, BodyPreds, UniquePreds).


get_stratum(Pred, Assoc, S) :-
        member(S-Pred, Assoc),
        !.

update_stratum_assoc(Pred, Val, Assoc, NewAssoc) :-
        select(Old-Pred, Assoc, Rest), !,
        New is max(Old, Val),
        NewAssoc = [New-Pred | Rest].
update_stratum_assoc(Pred, Val, Assoc, [Pred-Val | Assoc]).



:- end_object.






