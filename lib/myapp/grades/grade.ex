defmodule Myapp.Grades.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "grades" do
    field :name, :string
    field :bonus_percentage, :integer
    has_many :customer, Myapp.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(grade, attrs) do
    grade
    |> cast(attrs, [:name, :bonus_percentage])
    |> validate_required([:name, :bonus_percentage])
  end
end
