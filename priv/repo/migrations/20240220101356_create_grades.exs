defmodule Myapp.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :bonus_percentage, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:grades, [:name])
  end
end
