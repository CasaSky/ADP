%%%-------------------------------------------------------------------
%%% @author talal
%%% @copyright (C) 2017, <HAW>
%%% @doc
%%%
%%% @end
%%% Created : 09. Apr 2017 19:20
%%%-------------------------------------------------------------------

-module(stack).
-author("talal").

%% API
-export([createS/0, push/2, pop/1, top/1, isEmptyS/1, equalS/2, reverseS/1]).

%createS: 0 -> stack
createS() -> liste:create().

%push: stack x elem -> stack
push(Stack,Elem) -> liste:insert(Stack,1, Elem).

%pop: stack -> stack
pop(Stack) -> liste:delete(Stack,1).

%top: stack -> elem
top(Stack) -> liste:retrieve(Stack,1).

%isEmptyS: stack -> bool
isEmptyS(Stack) -> liste:isEmpty(Stack).

%equalS: stack x stack -> bool
equalS(Stack1,Stack2) -> liste:equal(Stack1, Stack2).

%reverseS: stack -> stack
reverseS(Stack) ->
  case isEmptyS(Stack) of
    true -> createS();
    false -> reverseS_(Stack,liste:laenge(Stack))
  end.
reverseS_(Stack,1) -> {liste:retrieve(Stack,1),createS()};
reverseS_(Stack,Accu) -> {liste:retrieve(Stack,Accu), reverseS_(Stack,Accu-1)}.
