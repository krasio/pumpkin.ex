defmodule Pumpkin.Repo.Migrations.CreateEnvironments do
  use Ecto.Migration

  def change do
    create table(:environments, primary_key: false) do
      add :id, :string, primary_key: true

      timestamps()
    end
  end
end
