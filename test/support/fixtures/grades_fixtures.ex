defmodule Myapp.GradesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Myapp.Grades` context.
  """

  @doc """
  Generate a grade.
  """
  def grade_fixture(attrs \\ %{}) do
    {:ok, grade} =
      attrs
      |> Enum.into(%{
        bonus_percentage: 42,
        name: "some name"
      })
      |> Myapp.Grades.create_grade()

    grade
  end
end
