defmodule Myapp.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transaction" do
    field :value, :integer
    field :sign, :boolean, default: false
    belongs_to :customer, Myapp.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :sign])
    |> validate_required([:value, :sign])
  end
end
