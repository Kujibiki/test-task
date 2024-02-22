defmodule Myapp.PointsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Points` context.
  """

  @doc """
  Generate a point.
  """
  def point_fixture(attrs \\ %{}) do
    {:ok, point} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Myapp.Points.create_point()

    point
  end
end
