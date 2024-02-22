defmodule Myapp.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :currency, :string
    field :paid, :integer
    field :external_id, :binary_id
    belongs_to :customer, Myapp.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:external_id,:paid, :currency,:customer_id])
    |> unique_constraint(:external_id)
    |> validate_required([:external_id,:paid, :currency,:customer_id])
  end

end
