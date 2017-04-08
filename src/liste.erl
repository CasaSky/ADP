-module(liste).
-author("talal").

-export([create/0, isEmpty/1, equal/2, laenge/1, insert/3, delete/2, find/2, retrieve/2, concat/2, diffList/2, eoCount/1]).

%Facade create: 0 -> {}
create() -> {}.

%Facade isEmpty: List -> Bool
isEmpty({}) -> true;
isEmpty(_) -> false.

%Facade laenge: List -> Int
equal(List,List) -> true;
equal(_,_) -> false.

%Facade laenge: List -> Int
laenge(List) -> laenge_(List).
laenge_({}) -> 0;
laenge_({_}) -> 1;
laenge_({_,Rest}) -> 1+laenge(Rest).

%Facade insert: List x Pos x Elem -> List
insert(List,Pos,Elem) when is_number(Pos) and is_number(Elem) ->
  insert_(List,Pos,Elem);
insert(_,_,_) -> {'konnte das Element nicht einfuegen'}.
  %Pos =< laenge(List)+1,
insert_({},1,Elem) -> {Elem};
insert_(List,1,Elem) -> {Elem,List};
insert_({Head,Tail},Pos,Elem) -> {Head,insert(Tail,Pos-1,Elem)};
insert_({Tail},Pos,Elem) -> {Tail,insert({},Pos-1,Elem)};
insert_(_,_,_) -> {'konnte das Element nicht einfuegen'}.

%Facade delete: List x Pos -> List
delete(List,Pos) when Pos>0 -> %Pos=<laenge(List),
  delete_(List,Pos);
delete(_,_) -> {'loeschen ist nicht moeglich'}.
delete_({_,Tail},1) -> Tail;
delete_({_},1) -> {};
delete_({Head,Tail},Pos) -> {Head,delete(Tail,Pos-1)};
delete_(_,_) -> {'loeschen ist nicht moeglich'}.

%Facade find: List x Elem -> Pos
find(List,Elem) -> find(List,Elem,1).
find({Elem,_},Elem,Accu) -> Accu;
find({Elem},Elem,Accu) -> Accu;
find({_},_,_) -> null;
find({_,Tail},Elem,Accu) -> find(Tail,Elem,Accu+1);
find({},_,_) -> null.

%Facade retrieve: List x Pos -> Elem
retrieve(List,Pos) when Pos>0 -> %Pos=<laenge(List),
  retrieve_(List,Pos);
retrieve(_,_) -> {'retrieve failed'}.
retrieve_({Elem},1) -> Elem;
retrieve_({Elem,_},1) -> Elem;
retrieve_({_,Tail},Pos) -> retrieve(Tail,Pos-1);
retrieve_({},_) -> null;
retrieve_({_},_) -> null.

%concat: List x List -> List
concat({Elem},List) -> {Elem,List};
concat({},List) -> List;
concat(List,{}) -> List;
concat({Head,Tail},List) -> {Head,concat(Tail,List)}.

%diffList: List x List -> List
diffList(List1,List2) -> diffList_(List1,List2).
diffList_({},_) -> {};
diffList_({Elem},List2) -> getDiffList(Elem,{},List2);
diffList_({Head,Tail},List2) -> getDiffList(Head,Tail,List2).
%Hilfsmethode: benutzt find methode, der Head wird nur dann in der neuen Liste angehaengt wenn er nicht in Liste2 gefunden ist
getDiffList(Head,Tail,List2) ->  Pos = find(List2,Head),
  if Pos /= null -> {Head,diffList(Tail,List2)};
    true         -> diffList(Tail,List2)
  end.

%eoCount: List -> [int, int]
eoCount(List) -> eoCount(List,List,[0,0]).

eoCount({_},{_},[Gerade,Ungerade]) -> [Gerade,Ungerade+1];
eoCount(_,{},[Gerade,Ungerade]) -> [Gerade+1,Ungerade];
eoCount(List,{_,Tail},[Gerade,Ungerade]) -> L=laenge(List),
  if trunc(L / 2) * 2 == L -> Result = [Gerade+1,Ungerade], eoCount(Tail,Tail,Result);
     true       -> Result = [Gerade,Ungerade+1] , eoCount(Tail,Tail,Result)
  end.