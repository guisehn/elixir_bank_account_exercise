defmodule BankAccount do
  def start do
    await([], 0)
  end

  def await(actions, balance) do
    receive do
      {:check_balance, pid} -> send_balance(pid, balance)
      {:check_actions, pid} -> send_actions(pid, actions)
      {:deposit, amount}    -> balance = deposit(balance, amount); actions = actions ++ [{:deposit, amount}]
      {:withdraw, amount}   -> balance = withdraw(balance, amount); actions = actions ++ [{:withdraw, amount}]
    end

    await(actions, balance)
  end

  defp send_balance(pid, balance) do
    send(pid, {:balance, balance})
  end

  defp send_actions(pid, actions) do
    send(pid, {:actions, actions})
  end

  defp deposit(balance, amount) do
    balance + amount
  end

  defp withdraw(balance, amount) do
    balance - amount
  end
end
