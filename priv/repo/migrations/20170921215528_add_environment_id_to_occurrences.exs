defmodule Pumpkin.Repo.Migrations.AddEnvironmentIdToOccurrences do
  use Ecto.Migration

  def change do
    alter table(:occurrences) do
      add :environment_id, references(:environments, type: :string), null: false
    end
  end
end
