defmodule Pumpkin.Repo.Migrations.CreateOccurrences do
  use Ecto.Migration

  def change do
    create table(:occurrences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :message, :string, null: false
      add :occurred_at, :naive_datetime, null: false
      add :data, :map

      timestamps()
    end

  end
end
