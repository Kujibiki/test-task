defmodule Myapp.OrdersTest do
  use Myapp.DataCase

  alias Myapp.Orders

  describe "orders" do
    alias Myapp.Orders.Order

    import Myapp.OrdersFixtures

    @invalid_attrs %{currency: nil, paid: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{currency: "some currency", paid: 42}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.currency == "some currency"
      assert order.paid == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{currency: "some updated currency", paid: 43}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.currency == "some updated currency"
      assert order.paid == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
