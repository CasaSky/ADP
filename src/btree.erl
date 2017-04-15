%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2017 20:03
%%%-------------------------------------------------------------------
-module(btree).
-author("talal").

%% API
-export([initBT/0, isBT/1, insertBT/2, isEmptyBT/1, equalBT/2]).

-define(MAX, 2432902008176640000).
-define(MIN, -2432902008176640000).

%initBT 0 -> btree
initBT() -> {}.

%isBT btree -> bool
isBT(Btree={Elem,_,_,_}) when is_integer(Elem) -> case (Btree==initBT()) of
                 true -> true;
                 false ->isBT_(Btree,?MAX,?MIN)
               end;
isBT({}) -> true;
isBT(_) -> false.

isBT_({},_,_) -> true;
isBT_({Elem,1,{},{}},Min,Max) when is_integer(Elem) and (Elem<Max) and (Elem>Min) -> true;
isBT_({Elem,Hoehe,LBtree,RBtree},Max,Min) when is_integer(Elem) and (Elem<Max) and (Elem>Min) ->
  case (Hoehe == maxHoehe(LBtree,RBtree) + 1) of
      true ->  isBT_(LBtree,Elem,Min) and isBT_(RBtree,Max,Elem);
      false -> false
  end;
isBT_(_,_,_) -> false.

%insertBT: btree x elem -> btree
insertBT({},Elem) -> {Elem,1,{},{}};
insertBT({KnotenElem,Hoehe,{},{}}, Elem) when KnotenElem > Elem -> {KnotenElem,Hoehe+1,{Elem,1,{},{}},{}};
insertBT({KnotenElem,Hoehe,{},{}}, Elem) when KnotenElem < Elem -> {KnotenElem,Hoehe+1,{},{Elem,1,{},{}}};

insertBT({KnotenElem,Hoehe,{},RBtree}, Elem) when KnotenElem > Elem -> {KnotenElem,Hoehe,{Elem,1,{},{}},RBtree};
insertBT({KnotenElem,Hoehe,{},RBtree}, Elem) -> {KnotenElem,Hoehe+1,{},insertBT(RBtree,Elem)};
insertBT({KnotenElem,Hoehe,LBtree,{}}, Elem) when KnotenElem < Elem -> {KnotenElem,Hoehe,LBtree,{Elem,1,{},{}}};
insertBT({KnotenElem,Hoehe,LBtree,{}}, Elem) -> {KnotenElem,Hoehe+1,insertBT(LBtree,Elem),{}};

insertBT({KnotenElem,Hoehe,LBtree,RBtree}, Elem) ->
  if KnotenElem > Elem -> NewLBtree = insertBT(LBtree,Elem), MaxHoehe = maxHoehe(NewLBtree,RBtree), {KnotenElem,MaxHoehe+1, NewLBtree, RBtree};
    KnotenElem < Elem -> NewRBtree = insertBT(RBtree,Elem), MaxHoehe = maxHoehe(LBtree,NewRBtree), {KnotenElem,MaxHoehe+1, LBtree, NewRBtree};
    true -> {KnotenElem,Hoehe,LBtree,RBtree}
  end.

maxHoehe({},{}) -> 0;
maxHoehe({_,Hoehe1,_,_},{}) -> Hoehe1;
maxHoehe({},{_,Hoehe2,_,_}) -> Hoehe2;
maxHoehe({_,Hoehe1,_,_},{_,Hoehe2,_,_}) -> if Hoehe1>Hoehe2-> Hoehe1;
                                             true -> Hoehe2
                                           end.


%isEmptyBT: btree -> bool
isEmptyBT(Btree) -> Btree == initBT().

%equalBT: btree x btree -> bool
equalBT({},{}) -> true;
equalBT({Elem1,Hoehe1,LBtree1,RBtree1},{Elem2,Hoehe2,LBtree2,RBtree2}) ->
  (Elem1==Elem2) and (Hoehe1==Hoehe2) and equalBT(LBtree1,LBtree2) and equalBT(RBtree1,RBtree2);
equalBT(_Btree1,_Btree2) -> false.
