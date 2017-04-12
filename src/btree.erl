%%%-------------------------------------------------------------------
%%% @author talal
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2017 20:03
%%%-------------------------------------------------------------------
-module(btree).
-author("talal").

%% API
-export([initBT/0, isBT/1, insertBT/2, isEmptyBT/1, equalBT/2]).

%initBT 0 -> btree
initBT() -> {}.

%isBT btree -> bool
isBT(Btree) -> case (Btree==initBT()) of
                 true -> true;
                 false ->{Elem,_,_,_} = Btree, isBT(Btree,Elem+1,Elem-1)
               end.

isBT({_,1,{},{}},_,_) -> true;
isBT({Elem,_,LBtree,RBtree},Max,Min) when (Elem<Max) and (Elem>Min) -> isBT(LBtree, Elem, Min) and isBT(RBtree,Max,Elem);
isBT(_,_,_) -> false.

%insertBT: btree x elem -> btree
insertBT({},Elem) -> {Elem,1,{},{}};
insertBT({KnotenElem,Hoehe,{},{}}, Elem) when KnotenElem > Elem -> {KnotenElem,Hoehe+1,{Elem,1,{},{}},{}};
insertBT({KnotenElem,Hoehe,{},{}}, Elem) when KnotenElem < Elem -> {KnotenElem,Hoehe+1,{},{Elem,1,{},{}}};

insertBT({KnotenElem,Hoehe,{},RBtree}, Elem) when KnotenElem > Elem -> {KnotenElem,Hoehe,{Elem,1,{},{}},RBtree};
insertBT({KnotenElem,Hoehe,{},RBtree}, Elem) -> {KnotenElem,Hoehe+1,{},insertBT(RBtree,Elem)};
insertBT({KnotenElem,Hoehe,LBtree,{}}, Elem) when KnotenElem < Elem -> {KnotenElem,Hoehe,LBtree,{Elem,1,{},{}}};
insertBT({KnotenElem,Hoehe,LBtree,{}}, Elem) -> {KnotenElem,Hoehe+1,insertBT(LBtree,Elem),{}};

insertBT({KnotenElem,Hoehe,LBtree,RBtree}, Elem) -> MaxHoehe = maxHoehe(LBtree,RBtree),
  if KnotenElem > Elem -> {KnotenElem,MaxHoehe+1, insertBT(LBtree,Elem),RBtree};
    KnotenElem < Elem -> {KnotenElem,MaxHoehe+1, LBtree, insertBT(RBtree,Elem)};
    true -> {KnotenElem,Hoehe,LBtree,RBtree}
  end.

maxHoehe({_,Hoehe1,_,_},{_,Hoehe2,_,_}) -> if Hoehe1>Hoehe2-> Hoehe1;
                                              true -> Hoehe2
                                           end.

%isEmptyBT: btree -> bool
isEmptyBT(Btree) -> equalBT(Btree,{}).

%equalBT: btree x btree -> bool
equalBT(Btree1,Btree2) ->
  case (isEmptyBT(Btree1) and not isEmptyBT(Btree2)) of
    true -> false;
    false -> {Elem1,Hoehe1,LBtree1,RBtree1} = Btree1, {Elem2,Hoehe2,LBtree2,RBtree2} = Btree2,
      (Elem1==Elem2) and (Hoehe1==Hoehe2) and equalBT(LBtree1,LBtree2) and equalBT(RBtree1,RBtree2)
  end.



