defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:check_balance, self})
    assert_receive {:balance, 0}
  end

  test "has balance incremented by the amount of a deposit" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 10})
    send(account, {:check_balance, self})
    assert_receive {:balance, 10}
  end

  test "has balance decreased by the amount of a withdrawal" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 50})
    send(account, {:withdraw, 20})
    send(account, {:check_balance, self})
    assert_receive {:balance, 30}
  end
end
