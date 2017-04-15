%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 09. Apr 2017 19:20
%%%-------------------------------------------------------------------

-module(liste).
-author("talal").

-export([create/0, isEmpty/1, equal/2, laenge/1, insert/3, delete/2, find/2, retrieve/2, concat/2, diffListe/2, eoCount/1]).

%create: 0 -> {}
create() -> {}.

%isEmpty: List -> Bool
isEmpty({}) -> true;
isEmpty(_) -> false.

%equal: List,List -> Bool
equal({},{}) -> true;
equal({Head,Tail1},{Head,Tail2}) -> equal(Tail1,Tail2);
equal(_,_) -> false.


%laenge: List -> Int
laenge(List) -> laenge_(List,0).
laenge_({},Accu) -> Accu;
laenge_({_,Rest},Accu) -> laenge_(Rest,Accu+1);
laenge_(_,_) -> nil.

%insert: List x Pos x Elem -> List
insert(List,Pos,Elem) when is_integer(Pos) -> insert_(List,Pos,Elem);
insert(List,_,_) -> List.
insert_({},1,Elem) -> {Elem,{}};
insert_(List,1,Elem) -> {Elem,List};
insert_({Head,Tail},Pos,Elem) -> {Head,insert(Tail,Pos-1,Elem)};
insert_(List,_,_) -> List.

%delete: List x Pos -> List
delete(List,Pos) when is_integer(Pos) ->
  delete_(List,Pos);
delete(List,_) -> List.
delete_({_,Tail},1) -> Tail;
delete_({Head,Tail},Pos) -> {Head,delete(Tail,Pos-1)};
delete_(List,_) -> List.

%find: List x Elem -> Pos
find(List,Elem) -> find(List,Elem,1).
find({Elem,_},Elem,Accu) -> Accu;
find({},_,_) -> nil;
find({_,Tail},Elem,Accu) -> find(Tail,Elem,Accu+1);
find(_,_,_) -> nil.

%retrieve: List x Pos -> Elem
retrieve(List,Pos) when is_integer(Pos)->
  retrieve_(List,Pos);
retrieve(_,_) -> nil.
retrieve_({},_) -> nil;
retrieve_({Elem,_},1) -> Elem;
retrieve_({_,Tail},Pos) -> retrieve_(Tail,Pos-1);
retrieve_(_,_) -> nil.

%concat: List x List -> List
concat({},List) -> List;
concat(List,{}) -> List;
concat({Head,Tail},{Head2,Tail2}) -> {Head,concat(Tail,{Head2,Tail2})};
concat(_,_) -> nil.

%diffListe: List x List -> List
diffListe(List,{}) -> List;
diffListe({},_) -> {};
diffListe({Head1,Tail1},{Head2,Tail2}) ->
  case find({Head2,Tail2},Head1) == nil of
    true -> {Head1,diffListe(Tail1,{Head2,Tail2})};
    false -> diffListe(Tail1,{Head2,Tail2})
  end;
diffListe(_,_) -> nil.

%eoCount: List -> {int, int}
eoCount(List) -> eoCountL(List,{0,0}).
eoCountL(List,Result) -> eoCount(List,eoCount_(List,Result)).
eoCount({},{0,0}) -> {1,0};
eoCount({IList={},Tail},Result) -> Result1 = eoCountL(IList,Result), eoCount(Tail,Result1);
eoCount({IList={_H,_T},Tail},Result) -> Result1 = eoCountL(IList,Result), eoCount(Tail,Result1);
eoCount({_Head,{IList={},Tail}},Result) -> Result1 = eoCountL(IList,Result), eoCount(Tail,Result1);
eoCount({_Head,{IList={_H,_T},Tail}},Result) -> Result1 = eoCountL(IList,Result), eoCount(Tail,Result1);
eoCount({_Head,{_Tail1,{IList={_H,_T},_Tail2}}},Result) -> eoCountL(IList,Result);
eoCount({_Head,{_Tail1,{IList={},_Tail2}}},Result) -> eoCountL(IList,Result);
eoCount(_,Result) -> Result.

%Hilfsfunktion des Rechnens
eoCount_(List,{Gerade,Ungerade}) ->  L=laenge(List),
  if L rem 2 == 1 -> {Gerade,Ungerade+1};
    true        -> {Gerade+1,Ungerade}
  end.