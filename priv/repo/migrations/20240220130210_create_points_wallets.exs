defmodule Myapp.Repo.Migrations.CreatePointsWallets do
  use Ecto.Migration

  def change do
    create table(:points_wallets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)
      add :lock_version, :integer, default: 1

      timestamps(type: :utc_datetime)
    end

    create index(:points_wallets, [:customer_id])
  end
end
