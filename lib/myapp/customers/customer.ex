defmodule Myapp.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :name, :string
    field :email, :string
    field :phone, :string
    belongs_to :grade, Myapp.Grades.Grade
    has_many :order, Myapp.Orders.Order
    has_many :transaction, Myapp.Transactions.Transaction
    has_one :balance, Myapp.Balances.Balance
    has_one :points_wallet, Myapp.PointsWallets.PointsWallet

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone,:grade_id ])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
    |> validate_format(:phone, ~r/^\d{6,13}$/, message: "only 6 to 13 digits allowed")
    |> unique_constraint(:phone)
    |> foreign_key_constraint(:grade_id)
    |> validate_required_inclusion([:email, :phone])
  end

  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      # Add the error to the first field only since Ecto requires a field name for each error.
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect fields}")
    end
  end

  def present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end
end
