%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <https://logtalk.org/>
%  SPDX-FileCopyrightText: 1998-2025 Paulo Moura <pmoura@logtalk.org>
%  SPDX-License-Identifier: Apache-2.0
%
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%
%      http://www.apache.org/licenses/LICENSE-2.0
%
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(term_reader).

:- info([
	   version is 1:3:0,
	   author is 'Paulo Moura',
	   date is 2023-11-14,
	   comment is 'Term input/output from/to atom, chars, and codes.'
	]).

:- public(read_from_codes/2).


% main predicates

:- if(current_logtalk_flag(prolog_dialect, xsb)).
read_from_codes(Codes, Term) :-
		open(atom(Codes),read, Input),
		catch(read_term(Input, Term, []), Error, (close(Input),throw(Error))),
		close(Input).
:- elif(current_logtalk_flag(prolog_dialect, swi)).
read_from_codes(Codes, Term) :-
		read_term_from_atom(Codes, Term, []).
:- elif(current_logtalk_flag(prolog_dialect, yap)).
read_from_codes(Codes, Term) :-
		read_term_from_atomic(Codes, Term, []).
:- else.
read_from_codes(Codes,Term) :-
		term_io::read_from_codes(Codes,Term).
:- endif.
:- end_object.














