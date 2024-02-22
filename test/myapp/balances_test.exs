defmodule Myapp.BalancesTest do
  use Myapp.DataCase

  alias Myapp.Balances

  describe "balances" do
    alias Myapp.Balances.Balance

    import Myapp.BalancesFixtures

    @invalid_attrs %{value: nil, currency: nil, points: nil}

    test "list_balances/0 returns all balances" do
      balance = balance_fixture()
      assert Balances.list_balances() == [balance]
    end

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Balances.get_balance!(balance.id) == balance
    end

    test "create_balance/1 with valid data creates a balance" do
      valid_attrs = %{value: 42, currency: "some currency", points: 42}

      assert {:ok, %Balance{} = balance} = Balances.create_balance(valid_attrs)
      assert balance.value == 42
      assert balance.currency == "some currency"
      assert balance.points == 42
    end

    test "create_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Balances.create_balance(@invalid_attrs)
    end

    test "update_balance/2 with valid data updates the balance" do
      balance = balance_fixture()
      update_attrs = %{value: 43, currency: "some updated currency", points: 43}

      assert {:ok, %Balance{} = balance} = Balances.update_balance(balance, update_attrs)
      assert balance.value == 43
      assert balance.currency == "some updated currency"
      assert balance.points == 43
    end

    test "update_balance/2 with invalid data returns error changeset" do
      balance = balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Balances.update_balance(balance, @invalid_attrs)
      assert balance == Balances.get_balance!(balance.id)
    end

    test "delete_balance/1 deletes the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{}} = Balances.delete_balance(balance)
      assert_raise Ecto.NoResultsError, fn -> Balances.get_balance!(balance.id) end
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Balances.change_balance(balance)
    end
  end
end
