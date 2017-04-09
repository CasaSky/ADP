%%%-------------------------------------------------------------------
%%% @author talal
%%% @copyright (C) 2017, <COMPANY>
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
createQ() -> {}.

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
  end.

%enqueue: queue x elem -> queue
enqueue({InStack,OutStack},Elem) -> {stack:push(InStack,Elem),OutStack}.

%dequeue: queue -> queue
dequeue({InStack,OutStack}) ->
  case stack:isEmptyS(OutStack) of
    true  -> {stack:createS(),stack:pop(umstapeln(InStack, OutStack))};
    false -> {InStack,stack:pop(OutStack)}
  end.

%isEmptyQ: queue -> bool
isEmptyQ({InStack,OutStack}) -> stack:isEmptyS(InStack) and stack:isEmptyS(OutStack).

%equalQ: queue x queue -> bool todo evt. mittels Stack equal loesen
equalQ({InStack1,OutStack1},{InStack1,OutStack1}) -> true;
equalQ({{},{}},{{},{}}) -> true;
equalQ({_,_},{_,_}) -> false.
