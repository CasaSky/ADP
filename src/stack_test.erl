%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 15. Apr 2017 01:47
%%%-------------------------------------------------------------------
-module(stack_test).
-author("talal").

%% ====================================================================
%% API functions
%% ====================================================================
-include_lib("eunit/include/eunit.hrl").

%% ====================================================================
%% Internal functions
%% ====================================================================

create_test() -> ?assert(stack:createS() == {}).

%----------------------------------------------------------------------
pushPositive_test() ->
  ?assert(stack:push({}, 1) == {1, {} }),
  ?assert(stack:push({2, {3, {} }}, 1) == {1, {2, {3, {} }}}).

pushNegative_test() ->
  ?assert(stack:push({}, 1) /= 1),
  ?assert(stack:push({2, {3, {} }}, 1) /= {2, {3, {1, {} }}}).

%----------------------------------------------------------------------
popPositive_test() ->
  ?assert(stack:pop({}) == {}),
  ?assert(stack:pop({1, {2, {} }}) == {2, {} }).

popNegative_test() ->
  ?assert(stack:pop({}) /= {1, {}}),
  ?assert(stack:pop({1, {2, {} }}) /= {1, {} }).

%----------------------------------------------------------------------
topPositive_test() ->
  ?assert(stack:top({}) == nil),
  ?assert(stack:top({1, {2, {} }}) == 1),
  ?assert(stack:top({3, {4, {} }}) == 3).

topNegative_test() ->
  ?assert(stack:top({}) /= {1, {}}),
  ?assert(stack:top({1, {2, {} }}) /= {}),
  ?assert(stack:top({3, {4, {} }}) /= 4).

%----------------------------------------------------------------------
isEmptySPositive_test() ->
  ?assert(stack:isEmptyS({}) == true).

isEmptySNegative_test() ->
  ?assert(stack:isEmptyS({1, {2, {} }}) == false),
  ?assert(stack:isEmptyS({1, {2, {3, {} }}}) == false).

%----------------------------------------------------------------------
equalSPositive_test() ->
  ?assert(stack:equalS({}, {}) == true),
  ?assert(stack:equalS({1, {2, {} }}, {1, {2, {} }}) == true).

equalSNegative_test() ->
  ?assert(stack:equalS({}, {1, {}}) == false),
  ?assert(stack:equalS({1, {2, {} }}, {1, {3, {} }}) == false).

%----------------------------------------------------------------------
reverseSPositive_test() ->
  ?assert(stack:reverseS({}) == {}),
  ?assert(stack:reverseS({1, {2, {} }}) == {2, {1, {} }}),
  ?assert(stack:reverseS({1, {{a,{b,{}}}, {3, {}} }}) == {3, {{a,{b,{}}}, {1, {} }}}),
  ?assert(stack:reverseS({1, {2, {{a,{b,{}}}, {}} }}) == {{a,{b,{}}}, {2, {1, {} }}}),
  ?assert(stack:reverseS({{}, {2, {{a,{b,{}}}, {}} }}) == {{a,{b,{}}}, {2, {{}, {} }}}).

reverseSNegative_test() ->
  ?assert(stack:reverseS({}) /= {1, {} }),
  ?assert(stack:reverseS({1, {2, {} }}) /= {1, {2, {} }}).

%----------------------------------------------------------------------