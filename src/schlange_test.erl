%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 15. Apr 2017 01:50
%%%-------------------------------------------------------------------
-module(schlange_test).
-author("talal").

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).
-include_lib("eunit/include/eunit.hrl").

%% ====================================================================
%% Internal functions
%% ====================================================================
%%
create_test() ->
  ?assert(schlange:isEmptyQ(schlange:createQ())).

%----------------------------------------------------------------------
enqueuePositive_test() ->
  ?assert(schlange:enqueue(schlange:createQ(), 1) == {{1, {} }, {} }),
  ?assert(schlange:enqueue({{2, {3, {} }}, {} }, 1) == {{1, {2, {3, {} }}}, {} }),
  ?assert(schlange:enqueue({{2, {3, {} }}, {1, {} }}, 1) == {{1, {2, {3, {} }}}, {1, {} }}),
  ?assert(schlange:enqueue({}, a) == nil).
enqueueNegative_test() ->
  ?assert(schlange:enqueue(schlange:createQ(), 1) /= {{1, {} }, {1, {} } }),
  ?assert(schlange:enqueue({{2, {3, {} }}, {} }, 1) /= {{2, {3, {1, {} }}}, {} }).

%----------------------------------------------------------------------
dequeuePositive_test() ->
  ?assert(schlange:dequeue(schlange:createQ()) == {{},{}}),
  ?assert(schlange:dequeue({{1, {2, {} }}, {1, {} }}) == {{1, {2, {} }}, {} }).

dequeueNegative_test() ->
  ?assert(schlange:dequeue(schlange:createQ()) /= {{1, {}},{}}),
  ?assert(schlange:dequeue({{1, {2, {} }}, {1, {} }}) /= {{1, {3, {} }}, {} }).

%----------------------------------------------------------------------
frontPositive_test() ->
  ?assert(schlange:front({{}, {} }) == nil),
  ?assert(schlange:front({{1, {2, {} }}, {} }) == 2),
  ?assert(schlange:front({{}, {1, {2, {} }}}) == 1).

frontNegative_test() ->
  ?assert(schlange:front({{}, {} }) /= {{}, {1, {} }}),
  ?assert(schlange:front({{1, {2, {} }}, {} }) /= 1),
  ?assert(schlange:front({{}, {1, {2, {} }}}) /= 2).

%----------------------------------------------------------------------
isEmptyQPositive_test() ->
  ?assert(schlange:isEmptyQ({{}, {} }) == true).

isEmptyQNegative_test() ->
  ?assert(schlange:isEmptyQ({{1, {} }, {} }) == false),
  ?assert(schlange:isEmptyQ({{1, {2, {} }}, {2, {} }}) == false).

%----------------------------------------------------------------------
equalQPositive_test() ->
  ?assert(schlange:equalQ({{99, {} }, {} }, {{99, {} }, {} }) == true).

equalQNegative_test() ->
  ?assert(schlange:equalQ({{1, {99,{} }}, {} }, {{1, {100,{} }}, {} }) == false).

%----------------------------------------------------------------------