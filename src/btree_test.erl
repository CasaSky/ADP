%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 15. Apr 2017 00:29
%%%-------------------------------------------------------------------
-module(btree_test).
-author("talal").

%% ====================================================================
%% API functions
%% ====================================================================

-export([]).

-include_lib("eunit/include/eunit.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================

initBT_test() ->
  BT = {},

  ?assert(btree:initBT() == BT).

%----------------------------------------------------------------------
isBTPositive_test() ->
  ?assert(btree:isBT({}) == true),
  ?assert(btree:isBT({10,4,{7,3,{6,2,{5,1,{},{}},{}},{8,1,{},{}}},{15,2,{11,1,{},{}},{16,1,{},{}}}}) == true),
  ?assert(btree:isBT({10,4,{7,3,{6,2,{5,1,{},{}},{}},{8,1,{},{}}},{15,3,{11,2,{},{14,1,{},{}}},{16,1,{},{}}}}) == true),
  ?assert(btree:isBT({4, 1, {}, {} }) == true),
  ?assert(btree:isBT({10, 4, {8, 3, {5, 2, {4, 1, {}, {} }, {} }, {9, 1, {}, {} }}, {15, 1, {}, {} }}) == true).

isBTNegative_test() ->
  ?assert(btree:isBT({99}) == false),
  ?assert(btree:isBT({atom, 1, {}, {}}) == false),
  ?assert(btree:isBT({10, 10, {8, 3, {5, 2, {4, 1, {}, {} }, {} }, {9, 1, {}, {} }}, {15, 1, {}, {} }}) == false),
  ?assert(btree:isBT({1, {2, {3, {{42, {42, {} }}, {4, {42, {} }}}}}}) == false),
  ?assert(btree:isBT({10, 3, {8, 2, {4, 1, {}, {} }, {} }, {9, 1, {}, {} }}) == false).

%----------------------------------------------------------------------
insertBTPositive_test() ->
  ?assert(btree:insertBT({}, 4) == {4, 1, {}, {}}),
  ?assert(btree:insertBT({4, 1, {}, {} }, 6) == {4, 2, {}, {6, 1, {}, {}} }),
  ?assert(btree:insertBT({4, 1, {}, {} }, 2) == {4, 2, {2, 1, {}, {} },{} }),
  ?assert(btree:insertBT({10,4,{7,3,{6,2,{5,1,{},{}},{}},{8,1,{},{}}},{15,2,{11,1,{},{}},{16,1,{},{}}}},14)
    =={10,4,{7,3,{6,2,{5,1,{},{}},{}},{8,1,{},{}}},{15,3,{11,2,{},{14,1,{},{}}},{16,1,{},{}}}}).

insertBTNegative_test() ->
  ?assert(btree:insertBT({}, 4) /= {4, 2, {}, {}}),
  ?assert(btree:insertBT({}, 4) /= {1, 4, {}, {}}),
  ?assert(btree:insertBT({4, 1, {}, {} }, 6) /= {6, 1, {}, {4, 2, {}, {}} }),
  ?assert(btree:insertBT({4, 1, {}, {} }, 6) /= {4, 1, {}, {6, 2, {}, {}} }),
  ?assert(btree:insertBT({4, 1, {}, {} }, 6) /= {4, 1, {}, {6, 2, {}, {}} }),
  ?assert(btree:insertBT({4, 1, {}, {} }, 2) /= {2, 2, {4, 1, {}, {} },{} }).

%----------------------------------------------------------------------
isEmptyBTPositive_test() ->
  ?assert(btree:isEmptyBT({}) == true).

isEmptyBTNegative_test() ->
  ?assert(btree:isEmptyBT({7, 2, {3, 1, {}, {} }, {} }) == false),
  ?assert(btree:isEmptyBT({7,1,{},{}}) == false).

%----------------------------------------------------------------------
equalBTPositive_test() ->
  ?assert(btree:equalBT({}, {}) == true),
  ?assert(btree:equalBT({7,1,{},{}},{7,1,{},{}}) == true).

equalNegative_test() ->
  ?assert(btree:equalBT({7,2,{3,1,{},{}},{}}, {7,1,{},{}}) == false).
