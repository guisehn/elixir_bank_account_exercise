Example of use:
```
$ cd /path/to/elixir_bank_account_exercise
$ iex -S mix

iex(1)> view_mailbox = fn -> receive do; x -> x; end; end
#Function<20.54118792/0 in :erl_eval.expr/5>
iex(2)> account = spawn_link(BankAccount, :start, [])
#PID<0.87.0>
iex(3)> send(account, {:check_balance, self})
{:check_balance, #PID<0.84.0>}
iex(4)> view_mailbox.()
{:balance, 0}
iex(5)> send(account, {:deposit, 50})
{:deposit, 50}
iex(6)> send(account, {:withdraw, 20})
{:withdraw, 20}
iex(7)> send(account, {:check_balance, self})
{:check_balance, #PID<0.84.0>}
iex(8)> send(account, {:check_actions, self})
{:check_actions, #PID<0.84.0>}
iex(9)> view_mailbox.()
{:balance, 30}
iex(10)> view_mailbox.()
{:actions, [deposit: 50, withdraw: 20]}
```

Run tests:
```
mix test
```