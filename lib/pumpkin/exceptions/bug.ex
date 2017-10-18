defmodule Pumpkin.Exceptions.Bug do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Pumpkin.Repo
  alias Pumpkin.Exceptions.Bug
  alias Pumpkin.Exceptions.Occurrence


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bugs" do
    belongs_to :primary_occurrence, Occurrence
    has_many :occurrences, Occurrence

    timestamps()
  end

  @doc false
  def changeset(%Bug{} = bug, attrs) do
    bug
    |> cast(attrs, [:primary_occurrence_id])
    |> validate_required([])
  end

  def get_by_message(message) do
    Bug
    |> Bug.for_message(message)
    |> Repo.one
  end

  def create_for_occurence(occurrence_id) do
    %Bug{}
    |> Bug.changeset(%{primary_occurrence_id: occurrence_id})
    |> Repo.insert!
  end

  def for_message(query, message) do
    from b in query,
      join: o in assoc(b, :primary_occurrence),
      where: o.message == ^message
  end
end
