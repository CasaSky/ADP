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
isBT(Btree) -> isBT(Btree, 1).
isBT({},_) -> true;
isBT({_,1,{},{}},1) -> true;
isBT({_,Hoehe,{},{}},Hoehe) -> true;
isBT({Elem,Accu,LinkBtree,{}},Accu) ->
  case getElem(LinkBtree) < Elem  of
    true  -> isBT(LinkBtree,Accu+1);
    false -> false
  end;
isBT({Elem,Accu,{},RechtBtree},Accu) ->
  case getElem(RechtBtree) > Elem of
    true  -> isBT(RechtBtree,Accu+1);
    false -> false
  end;
isBT({Elem,Accu,LinkBtree,RechtBtree},Accu) ->
  case (getElem(LinkBtree) < Elem) and (getElem(RechtBtree) > Elem) of
    true  -> isBT(LinkBtree,Accu+1) and
            isBT(RechtBtree,Accu+1);
    false -> false
  end;
isBT(_,_) -> false.

getElem({Elem,_,_,_}) -> Elem.

%insertBT: btree x elem -> btree
insertBT({},Elem) -> {Elem,1,{},{}};
insertBT({KnotenElem,Hoehe,{},_}, Elem) when KnotenElem > Elem -> {KnotenElem,Hoehe,{Elem,Hoehe+1,{},{}},{}};
insertBT({KnotenElem,Hoehe,_,{}}, Elem) when KnotenElem < Elem -> {KnotenElem,Hoehe,{},{Elem,Hoehe+1,{},{}}};

insertBT({KnotenElem,_,LinkBtree,_}, Elem) when KnotenElem > Elem -> insertBT(LinkBtree,Elem);
insertBT({KnotenElem,_,_,RechtBtree}, Elem) when KnotenElem < Elem -> insertBT(RechtBtree,Elem).

%isEmptyBT: btree -> bool
isEmptyBT({}) -> true;
isEmptyBT(_) -> false.

%equalBT: btree x btree -> bool
equalBT(Btree,Btree) -> true;
equalBT(_,_) -> false.
