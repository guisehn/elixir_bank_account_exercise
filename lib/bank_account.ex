defmodule BankAccount do
  def start do
    await(0)
  end

  def await(balance) do
    receive do
      {:check_balance, pid} -> send_balance(pid, balance)
      {:deposit, amount}    -> balance = deposit(balance, amount)
      {:withdraw, amount}   -> balance = withdraw(balance, amount)
    end

    await(balance)
  end

  defp send_balance(pid, balance) do
    send(pid, {:balance, balance})
  end

  defp deposit(balance, amount) do
    balance + amount
  end

  defp withdraw(balance, amount) do
    balance - amount
  end
end
