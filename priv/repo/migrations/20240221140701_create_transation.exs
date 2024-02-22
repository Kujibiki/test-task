defmodule Myapp.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer
      add :sign, :boolean, default: false, null: false
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:transaction, [:customer_id])
  end
end
