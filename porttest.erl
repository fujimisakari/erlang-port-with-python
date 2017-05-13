%% porttest.erl

-module(porttest).
-compile(export_all).

start() ->
    spawn(fun() ->
		  register(porttest, self()),
		  process_flag(trap_exit, true),
		  Port = open_port({spawn, "./erlang_port/my_protocol.py"}, [{packet, 2}, binary]),
		  loop(Port)
	  end).

stop() ->
    porttest ! stop.

twice(X) -> call_port({twice, X}).
sum(X, Y) -> call_port({sum, X, Y}).
hello(Name) -> call_port({hello, Name}).

call_port(Msg) ->
    porttest ! {call, self(), Msg},
    receive
	{porttest, Result} ->
		io:format("received: '~p' ~p ~n", [Result, self()])
    end.

loop(Port) ->
    receive
	{call, Caller, Msg} ->
	    Port ! {self(), {command, encode(Msg)}}, 
        receive
        {Port, {data, Data}} ->
            Caller ! {porttest, decode(Data)};
		X ->
			io:format("unknown message: [~w]~n", [X]),
			throw('Unknown message received.')
        end,
		loop(Port)
    end.

encode({twice, X}) -> term_to_binary({twice, X});
encode({sum, X, Y}) -> term_to_binary({sum, X, Y});
encode({hello, Name}) -> term_to_binary({hello, Name}).

decode(Data) -> binary_to_term(Data). 
