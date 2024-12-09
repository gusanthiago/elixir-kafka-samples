%%%-------------------------------------------------------------------
%% @doc consumerKafka public API
%% @end
%%%-------------------------------------------------------------------

-module(consumerKafka_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    consumerKafka_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
