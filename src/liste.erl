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
isEmpty(List) -> List == create().

%equal: List,List -> Bool
equal(List1,List2) ->
  case (isList(List1) and isList(List2)) of
    true -> case isEmpty(List1) of
              true -> isEmpty(List2);
              false -> case isEmpty(List2) == false of
                         true -> {Head1,Tail1} = List1, {Head2,Tail2} = List2, Head1==Head2 and equal(Tail1,Tail2);
                         false -> false
                       end
            end;
    false -> false
  end.


%laenge: List -> Int
laenge(List) -> laenge_(List).
laenge_({}) -> 0;
laenge_({_,Rest}) -> 1+laenge(Rest).

%insert: List x Pos x Elem -> List
insert(List,Pos,Elem) ->
  if Pos > 0 -> insert_(List,Pos,Elem);
    true    -> List
  end.
insert_({},1,Elem) -> {Elem,{}};
insert_(List,1,Elem) -> {Elem,List};
insert_({Head,Tail},Pos,Elem) -> {Head,insert(Tail,Pos-1,Elem)};
insert_(List,_,_) -> List.

%delete: List x Pos -> List
delete(List,Pos) when Pos>0 ->
  delete_(List,Pos);
delete(List,_) -> List.
delete_({_,Tail},1) -> Tail;
delete_({Head,Tail},Pos) -> {Head,delete(Tail,Pos-1)};
delete_(List,_) -> List.

%find: List x Elem -> Pos
find(List,Elem) -> find(List,Elem,1).
find({Elem,_},Elem,Accu) -> Accu;
find({},_,_) -> null;
find({_,Tail},Elem,Accu) -> find(Tail,Elem,Accu+1);
find(_,_,_) -> null.

%retrieve: List x Pos -> Elem
retrieve(List,Pos) when Pos>0 ->
  retrieve_(List,Pos);
retrieve(_,_) -> null.
retrieve_({},_) -> null;
retrieve_({Elem,_},1) -> Elem;
retrieve_({_,Tail},Pos) -> retrieve_(Tail,Pos-1);
retrieve_(_,_) -> null.

%concat: List x List -> List
concat({},List) -> List;
concat(List,{}) -> List;
concat({Head,Tail},List) -> {Head,concat(Tail,List)};
concat(_,_) -> null.

%diffList: List x List -> List
diffList({},_) -> {};
diffList({Head,Tail},List2) -> diffList_(Head,Tail,List2);
diffList(_,_) -> null.
%Hilfsmethode: Prueft ob Head nicht in List enthalten ist, dann wird der eingefuegt
diffList_(Head,Tail,List) ->  Pos = find(List,Head),
  if Pos == null -> {Head,diffList(Tail,List)};
    true         -> diffList(Tail,List)
  end.

%eoCount: List -> [int, int]
eoCount(List) -> eoCount(List,{0,0}).
eoCount({},{Gerade,Ungerade}) -> {Gerade+1,Ungerade};
eoCount(List,Result) ->
  case (isList(List)) of
    true -> {Head,Tail} = List,
      NewResult = eoCount_(List,Result),
      case (isList(Head)) of
        true -> {_,T} = Head, eoCount(Tail, eoCount(T,eoCount_(Head,NewResult)));
        false ->  eoCount(Tail,NewResult)
      end;
    false -> Result
  end.

%Hilfsfunktion des Rechnens
eoCount_(List,{Gerade,Ungerade}) ->  L=laenge(List),
  if L rem 2 == 1 -> {Gerade,Ungerade+1};
    true        -> {Gerade+1,Ungerade}
  end.

isList({}) -> true;
isList({_,T}) -> isList(T);
isList(_)-> false.