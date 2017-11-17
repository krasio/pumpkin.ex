defmodule Pumpkin.Exceptions.Environment do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Pumpkin.Exceptions.Environment
  alias Pumpkin.Exceptions.Occurrence


  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "environments" do
    has_many :occurrences, Occurrence
    timestamps()

    field :bugs_count, :integer, virtual: true
  end

  @doc false
  def changeset(%Environment{} = environment, attrs) do
    environment
    |> cast(attrs, [:id])
    |> validate_required([:id])
    |> unique_constraint(:id, name: :environments_pkey)
  end

  @doc false
  def with_bugs_count(query \\ Environment) do
    from e in query,
      left_join: o in Occurrence, on: e.id == o.environment_id,
      group_by: :id,
      select: %{e | bugs_count: count(e.id)}
  end
end
