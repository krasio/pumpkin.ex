defmodule Pumpkin.Repo.Migrations.AddBugIdToOccurrences do
  use Ecto.Migration

  def change do
    alter table(:occurrences) do
      add :bug_id, references(:bugs, type: :binary_id), null: true
    end
  end
end
