defmodule Myapp.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :external_id, :binary_id
      add :paid, :integer
      add :currency, :string
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:customer_id])
    create unique_index(:orders, [:external_id])
  end
end
