%%%-------------------------------------------------------------------
%%% @author talal and michel
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 09. Apr 2017 22:14
%%%-------------------------------------------------------------------
-module(schlange).
-author("talal").

%% API
-export([createQ/0, front/1, enqueue/2, dequeue/1, isEmptyQ/1, equalQ/2]).

%createQ: 0 -> queue
createQ() -> {stack:createS(),stack:createS()}.

%umstapeln InStack in OutStack entleeren und OutStack zurueck liefern
umstapeln(InStack,OutStack) ->
  case stack:isEmptyS(InStack) of
    true  -> OutStack;
    false -> umstapeln(stack:pop(InStack), stack:push(OutStack, stack:top(InStack)))
  end.

%front: queue -> elem
front({InStack,OutStack}) ->
  case stack:isEmptyS(OutStack) of
    true  -> stack:top(umstapeln(InStack, OutStack));
    false -> stack:top(OutStack)
  end;
front(_) -> nil.

%enqueue: queue x elem -> queue
enqueue({InStack,OutStack},Elem) -> {stack:push(InStack,Elem),OutStack};
%Achtung! Abstraktionsebene verletzt: Test Beispiel vom Prof. auf  {}
enqueue({},Elem) -> {stack:push(stack:createS(),Elem),stack:createS()};
enqueue(_,_) -> nil.

%dequeue: queue -> queue
dequeue({InStack,OutStack}) ->
  case stack:isEmptyS(OutStack) of
    true  -> {stack:createS(),stack:pop(umstapeln(InStack, OutStack))};
    false -> {InStack,stack:pop(OutStack)}
  end;
dequeue(_) -> nil.

%isEmptyQ: queue -> bool
isEmptyQ({InStack,OutStack}) -> stack:isEmptyS(InStack) and stack:isEmptyS(OutStack);
%Achtung! Abstraktionsebene verletzt: Test Beispiel vom Prof auf  {}
isEmptyQ({}) -> true;
isEmptyQ(_) -> nil.

%equalQ: queue x queue -> bool
equalQ({InStack1,OutStack1},{InStack2,OutStack2}) -> stack:equalS(InStack1,InStack2) and stack:equalS(OutStack1,OutStack2);
%Achtung! Abstraktionsebene verletzt: Test Beispiel vom Prof auf  {}
equalQ({},{}) -> true;
equalQ(_,_) -> nil.