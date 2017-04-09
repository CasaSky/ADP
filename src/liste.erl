%%%-------------------------------------------------------------------
%%% @author talal
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 09. Apr 2017 19:20
%%%-------------------------------------------------------------------

-module(liste).
-author("talal").

-export([create/0, isEmpty/1, equal/2, laenge/1, insert/3, delete/2, find/2, retrieve/2, concat/2, diffList/2, eoCount/1]).

%create: 0 -> {}
create() -> {}.

%isEmpty: List -> Bool
isEmpty({}) -> true;
isEmpty(_) -> false.

%laenge: List -> Int
equal(List,List) -> true;
equal(_,_) -> false.

%laenge: List -> Int
laenge(List) -> laenge_(List).
laenge_({}) -> 0;
laenge_({_,Rest}) -> 1+laenge(Rest).

%insert: List x Pos x Elem -> List
insert(List,Pos,Elem) when is_number(Pos) and is_number(Elem) ->
  if Pos > 0 -> insert_(List,Pos,Elem);
     true    -> io:fwrite("insert is failed, Position must be positiv!~n"),List
  end;
insert(List,_,_) -> io:fwrite("insert is failed!~n"),List.
  %Pos =< laenge(List)+1,
insert_({},1,Elem) -> {Elem,{}};
insert_(List,1,Elem) -> {Elem,List};
insert_({Head,Tail},Pos,Elem) -> {Head,insert(Tail,Pos-1,Elem)};
insert_(List,_,_) -> io:fwrite("insert is failed!~n"), List.

%delete: List x Pos -> List
delete(List,Pos) when Pos>0 -> %Pos=<laenge(List),
  delete_(List,Pos);
delete(List,_) -> io:fwrite("delete is failed!~n"), List.
delete_({_,Tail},1) -> Tail;
delete_({Head,Tail},Pos) -> {Head,delete(Tail,Pos-1)};
delete_(List,_) -> io:fwrite("delete is failed!~n"), List.

%find: List x Elem -> Pos
find(List,Elem) -> find(List,Elem,1).
find({Elem,_},Elem,Accu) -> Accu;
find({},_,_) -> null;
find({_,Tail},Elem,Accu) -> find(Tail,Elem,Accu+1);
find(_,_,_) -> io:fwrite("find is failed!~n"), null.

%retrieve: List x Pos -> Elem
retrieve(List,Pos) when Pos>0 -> %Pos=<laenge(List),
  retrieve_(List,Pos);
retrieve(_,_) -> io:fwrite("retrieve is failed!~n"), null.
retrieve_({},_) -> null;
retrieve_({Elem,_},1) -> Elem;
retrieve_({_,Tail},Pos) -> retrieve_(Tail,Pos-1);
retrieve_(_,_) -> io:fwrite("retrieve is failed!~n"), null.

%concat: List x List -> List
concat({},List) -> List;
concat(List,{}) -> List;
concat({Head,Tail},List) -> {Head,concat(Tail,List)};
concat(_,_) -> io:fwrite("concat is failed!~n"), null.

%diffList: List x List -> List
diffList(List1,List2) -> diffList_(List1,List2).
diffList_({},_) -> {};
diffList_({Head,Tail},List2) -> getDiffList(Head,Tail,List2);
diffList_(_,_) -> io:fwrite("diffList is failed!~n"), null.
%Hilfsmethode: benutzt find methode, der Head wird nur dann in der neuen Liste angehaengt wenn er nicht in Liste2 gefunden ist
getDiffList(Head,Tail,List2) ->  Pos = find(List2,Head),
  if Pos == null -> {Head,diffList(Tail,List2)};
    true         -> diffList(Tail,List2)
  end.

%eoCount: List -> [int, int]
eoCount(List) -> eoCount(List,List,[0,0]).
eoCount(_,{},[Gerade,Ungerade]) -> [Gerade+1,Ungerade];
eoCount(List,{_,Tail},[Gerade,Ungerade]) -> L=laenge(List),
  if L rem 2 == 1 -> Result = [Gerade,Ungerade+1] , eoCount(Tail,Tail,Result);
     true       -> Result = [Gerade+1,Ungerade], eoCount(Tail,Tail,Result)
  end;
eoCount(_,_,_) -> io:fwrite("eoCount is failed!~n"), null.