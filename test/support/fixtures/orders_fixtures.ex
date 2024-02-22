defmodule Myapp.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        name: "some name",
        price: 42
      })
      |> Myapp.Orders.create_order()

    order
  end
end
