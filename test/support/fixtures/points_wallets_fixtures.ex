defmodule Myapp.PointsWalletsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.PointsWallets` context.
  """

  @doc """
  Generate a points_wallet.
  """
  def points_wallet_fixture(attrs \\ %{}) do
    {:ok, points_wallet} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Myapp.PointsWallets.create_points_wallet()

    points_wallet
  end
end
