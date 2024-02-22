defmodule Myapp.BalancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Balances` context.
  """

  @doc """
  Generate a balance.
  """
  def balance_fixture(attrs \\ %{}) do
    {:ok, balance} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        points: 42,
        value: 42
      })
      |> Myapp.Balances.create_balance()

    balance
  end
end
