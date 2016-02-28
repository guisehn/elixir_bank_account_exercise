defmodule BankAccount do
  def start do
    await([], 0)
  end

  def await(actions, balance) do
    receive do
      {:check_balance, pid} -> send_balance(pid, balance)
      {:check_actions, pid} -> send_actions(pid, actions)
      {:deposit, amount}    -> {actions, balance} = deposit(actions, balance, amount)
      {:withdraw, amount}   -> {actions, balance} = withdraw(actions, balance, amount)
    end

    await(actions, balance)
  end

  defp send_balance(pid, balance) do
    send(pid, {:balance, balance})
  end

  defp send_actions(pid, actions) do
    send(pid, {:actions, actions})
  end

  defp deposit(actions, balance, amount) do
    updated_action_list = actions ++ [{:deposit, amount}]
    {updated_action_list, balance + amount}
  end

  defp withdraw(actions, balance, amount) do
    updated_action_list = actions ++ [{:withdraw, amount}]
    {updated_action_list, balance - amount}
  end
end
