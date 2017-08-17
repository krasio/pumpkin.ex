defmodule Pumpkin.Repo.Migrations.CreateOccurrences do
  use Ecto.Migration

  def change do
    create table(:occurrences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :message, :string
      add :occurred_at, :naive_datetime
      add :data, :map

      timestamps()
    end

  end
end
