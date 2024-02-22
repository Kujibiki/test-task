defmodule Myapp.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> Myapp.Customers.create_customer()

    customer
  end
end
