defmodule Myapp.Balances.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "balances" do
    field :value, :integer
    field :currency, :string
    belongs_to :customer, Myapp.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:value, :currency, :points])
    |> validate_required([:value, :currency, :points])
  end
end
