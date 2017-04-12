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

%Leerer btree
isBT({},_) -> true;
%Der erste Knoten im Btree muss die Hoehe 1 haben
isBT({_,1,{},{}},1) -> true;
%Wenn ein Btree keine Teilbaeume hat (Blatt oder ein Btree mit nur einem Knoten)
isBT({_,Hoehe,{},{}},Hoehe) -> true;

%Wenn Btree nur einen Linkenteilbaum hat, wird dies geprueft
isBT({Elem,Accu,LBtree,{}},Accu) -> isLBT(LBtree,Elem), isBT(LBtree,Accu+1);
%Wenn Btree nur einen Rechtenteilbaum hat, wird dies geprueft
isBT({Elem,Accu,{},RBtree},Accu) -> isRBT(RBtree,Elem), isBT(RBtree,Accu+1);
%Wenn Btree beide Teilbaeume hat, werden beide geprueft
isBT({Elem,Accu,LBtree,RBtree},Accu) -> isLBT(LBtree), isRBT(RBtree,Elem), isBT(LBtree,Accu+1), isBT(LBtree,Elem), isBT(RBtree,Accu+1);
%Wenn Btree nicht korrekt ist
isBT(_,_) -> false.

%Prueft ob die Werteintervalle von LinksBtree korrekt sind
isLBT({Elem,Accu,_,{}},Accu,Max) -> Elem<Max;
isLBT({Elem,Accu,_,RBtree},Accu,Max) -> RElem = getElem(RBtree), (Elem<Max) and (RElem<Max).

%Prueft ob die Werteintervalle von RechtsBtree korrekt sind
isRBT({Elem,Accu,{},_},Accu,Min) -> Elem>Min;
isRBT({Elem,Accu,LBtree,_},Accu,Min) -> LElem = getElem(LBtree), (Elem<Min) and (LElem<Min).

%Liefert den Knoteninhalt der Wurzel vom gegebenen Btree
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
