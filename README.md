## ErlangPort with Python

Erlang's external program test.
Execute the python script using the BERT-RPC protocol.

## Example
```
$ erl

Eshell V8.3  (abort with ^G)
1> c(porttest).
{ok,porttest}
2> porttest:start().
<0.64.0>
3> porttest:hello('fujimisakari').
received: '<<"Hello, fujimisakari">>' <0.57.0>
ok
4> porttest:sum(50, 30).
received: '80' <0.57.0>
ok
5> porttest:twice(50).
received: '100' <0.68.0>
ok
```
