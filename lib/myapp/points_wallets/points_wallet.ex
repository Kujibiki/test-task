defmodule Myapp.PointsWallets.PointsWallet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "points_wallets" do
    field :value, :integer
    field :lock_version, :integer, default: 1
    belongs_to :customer, Myapp.Customers.Customer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(points_wallet, attrs) do
    points_wallet
    |> cast(attrs, [:value])
    |> validate_required([:value])
    |> Ecto.Changeset.optimistic_lock(:lock_version)
  end
end
