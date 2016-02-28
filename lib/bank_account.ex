defmodule BankAccount do
  def start do
    await
  end

  def await do
    receive do
      {:check_balance, pid} -> send_balance(pid)
    end

    await
  end

  defp send_balance(pid) do
    send(pid, {:balance, 0})
  end
end
