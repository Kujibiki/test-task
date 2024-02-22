defmodule Myapp.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer
      add :currency, :string
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:balances, [:customer_id])
  end
end
