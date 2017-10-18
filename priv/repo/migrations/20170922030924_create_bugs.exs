defmodule Pumpkin.Repo.Migrations.CreateBugs do
  use Ecto.Migration

  def change do
    create table(:bugs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :primary_occurrence_id, references(:occurrences, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:bugs, [:primary_occurrence_id])
  end
end
