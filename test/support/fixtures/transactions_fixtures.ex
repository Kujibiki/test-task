defmodule Myapp.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        balance: 42,
        sign: true,
        value: 42
      })
      |> Myapp.Transactions.create_transaction()

    transaction
  end
end
