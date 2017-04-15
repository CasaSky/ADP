%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 14. Apr 2017 17:56
%%%-------------------------------------------------------------------
-module(liste_test).
-author("talal").

%% ====================================================================
%% API functions
%% ====================================================================

-export([]).

-include_lib("eunit/include/eunit.hrl").


%% ====================================================================
%% Internal functions
%% ====================================================================

create_test() -> ?assert(liste:create() == {}).

%----------------------------------------------------------------------
isEmptyPositive_test() ->
  ?assert(liste:isEmpty({}) == true).

isEmptyNegative_test() ->
  ?assert(liste:isEmpty({99}) == false),
  ?assert(liste:isEmpty({atom, {}}) == false),
  ?assert(liste:isEmpty({1, {2, {} }}) == false),
  ?assert(liste:isEmpty({1, {2, {3, {} }}}) == false),
  ?assert(liste:isEmpty({1, {2, {3, {4, {5, {} }}}}}) == false).

%----------------------------------------------------------------------
equalPositive_test() ->
  ?assert(liste:equal({}, {}) == true),
  ?assert(liste:equal({1, {} }, {1, {} }) == true),
  ?assert(liste:equal({1, {2, {} }}, {1, {2, {} }}) == true),
  ?assert(liste:equal({1, {2, {3, {4, {5, {} }}}}}, {1, {2, {3, {4, {5, {} }}}}}) == true).

equalNegative_test() ->
  ?assert(liste:equal({}, {1, {} }) == false),
  ?assert(liste:equal({1, {} }, {} ) == false),
  ?assert(liste:equal({1, {} }, {1, {2, {} }}) == false),
  ?assert(liste:equal({}, {1, {2, {3, {4, {5, {} }}}}}) == false).

%----------------------------------------------------------------------
laengePositive_test() ->
  ?assert(liste:laenge({1}) == nil),
  ?assert(liste:laenge({}) == 0),
  ?assert(liste:laenge({atom, {} }) == 1),
  ?assert(liste:laenge({1, {} }) == 1),
  ?assert(liste:laenge({1, {2, {} }}) == 2),
  ?assert(liste:laenge({1, {2, {3, {4, {5, {} }}}}}) == 5).

laengeNegative_test() ->
  ?assert(liste:laenge({}) /= 1),
  ?assert(liste:laenge({1, {} }) /= nil),
  ?assert(liste:laenge({1, {} }) /= 2).

%----------------------------------------------------------------------
insertPositive_test() ->
  ?assert(liste:insert({}, 1, atom) == {atom, {} }),
  ?assert(liste:insert({}, 1, 1) == {1, {} }),
  ?assert(liste:insert({1, {2, {} }}, 1, 3) == {3, {1, {2, {} }}}),
  ?assert(liste:insert({1, {2, {} }}, 2, 3) == {1, {3, {2, {} }}}),
  ?assert(liste:insert({1, {2, {} }}, 3, 3) == {1, {2, {3, {} }}}),
  ?assert(liste:insert({1, {2, {} }}, 2, {a,{b,{}}}) == {1, {{a,{b,{}}}, {2, {} }}}).

insertNegative_test() ->
  ?assert(liste:insert({}, 1, atom) /= {1, {} }),
  ?assert(liste:insert({}, 1, 1) /= {{}, 1 }),
  ?assert(liste:insert({1, {2, {} }}, 1, 3) /= {1, {2, {3, {} }}}).

%----------------------------------------------------------------------
deletePositive_test() ->
  ?assert(liste:delete({1,{{a,{b,{}}},{3,{}}}}, 4) == {1,{{a,{b,{}}},{3,{}}}}),
  ?assert(liste:delete({1,{{a,{b,{}}},{3,{}}}}, 0) == {1,{{a,{b,{}}},{3,{}}}}),
  ?assert(liste:delete({1,{{a,{b,{}}},{3,{}}}}, 2) == {1,{3,{}}}),
  ?assert(liste:delete({1,{{a,{b,{}}},{3,{}}}}, bla) == {1,{{a,{b,{}}},{3,{}}}}).

deleteNegative_test() ->
  ?assert(liste:delete({1,{{a,{b,{}}},{3,{}}}}, 4) /= {1,{{a,{b,{}}},{}}}).

%----------------------------------------------------------------------
findPositive_test() ->
  ?assert(liste:find({}, 1) == nil),
  ?assert(liste:find({1, {} }, 1) == 1),
  ?assert(liste:find({1, {2, {3, {} }}}, 2) == 2),
  ?assert(liste:find({1, {2, {3, {} }}}, 3) == 3),
  ?assert(liste:find({1, {2, {3, {} }}}, 4) == nil).

findNegative_test() ->
  ?assert(liste:find({}, 1) /= 1),
  ?assert(liste:find({1, {} }, 1) /= {}),
  ?assert(liste:find({1, {2, {3, {} }}}, 2) /= 3),
  ?assert(liste:find({1, {2, {3, {} }}}, 3) /= {}),
  ?assert(liste:find({1, {2, {3, {} }}}, 4) /= 1).

%----------------------------------------------------------------------
retrievePositive_test() ->
  ?assert(liste:retrieve({}, 1) == nil),
  ?assert(liste:retrieve({1, {} }, 1) == 1),
  ?assert(liste:retrieve({1, {2, {3, {} }}}, 2) == 2).

retrieveNegative_test() ->
  ?assert(liste:retrieve({}, 1) /= {}),
  ?assert(liste:retrieve({1, {} }, 1) /= {}),
  ?assert(liste:retrieve({1, {2, {3, {} }}}, 2) /= 3).

%----------------------------------------------------------------------
concatPositive_test() ->
  ?assert(liste:concat({1, {} }, {2, {} }) == {1, {2, {} }}),
  ?assert(liste:concat({1, {2, {} }}, {3, {} }) == {1, {2, {3, {} }}}).

concatNegative_test() ->
  ?assert(liste:concat({1, {} }, {2, {} }) /= {2, {1, {} }}),
  ?assert(liste:concat({1, {2, {} }}, {3, {} }) /= {3, {2, {1, {} }}}).

%----------------------------------------------------------------------
diffListePositive_test() ->
  ?assert(liste:diffListe({}, {}) == {}),
  ?assert(liste:diffListe({1, {} }, {1, {} }) == {}),
  ?assert(liste:diffListe({1, {2, {} }}, {1, {2, {} }}) == {}),
  ?assert(liste:diffListe({1, {2, {} }}, {1, {} }) == {2, {} }).

diffListeNegative_test() ->
  ?assert(liste:diffListe({}, {}) /= 1),
  ?assert(liste:diffListe({1, {} }, {1, {} }) /= {1, {1, {} }}),
  ?assert(liste:diffListe({1, {2, {} }}, {1, {2, {} }}) /= {1, {2, {1, {2, {} }}}}).

%----------------------------------------------------------------------
eoCount_test() ->
  ?assert(liste:eoCount({}) == {1,0}),
  ?assert(liste:eoCount({1, {} }) == {0,1}),
  ?assert(liste:eoCount({ 1, {2, {}}}) == {1,0}),
  ?assert(liste:eoCount({ {a,{}}, {2, {}}}) == {1,1}),
  ?assert(liste:eoCount({ {a,{b,{}}}, {2, {}}}) == {2,0}),
  ?assert(liste:eoCount({ 1, {2, {3, {}}}}) == {0,1}),
  ?assert(liste:eoCount({ 1, {{a,{}}, {3, {}}}}) == {0,2}),
  ?assert(liste:eoCount({ 1, {{a,{b,{}}}, {3, {}}}}) == {1,1}),
  ?assert(liste:eoCount({ 1, {2, {{a,{}}, {}}}}) == {0,2}),
  ?assert(liste:eoCount({ 1, {2, {{a,{b,{}}}, {}}}}) == {1,1}),
  ?assert(liste:eoCount({ {}, {{},{}}}) == {3,0}),
  ?assert(liste:eoCount({ {}, {2 ,{ {},{}}}}) == {2,1}).

%----------------------------------------------------------------------