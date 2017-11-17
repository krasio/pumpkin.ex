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

    field :message, :string, virtual: true
    field :first_occurred_at, :naive_datetime, virtual: true
    field :last_occurred_at, :naive_datetime, virtual: true
    field :occurrences_count, :integer, virtual: true
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

  def for_environment(query, environment) do
    from b in query,
      join: po in assoc(b, :primary_occurrence),
      where: po.environment_id == ^environment.id,
      select: %{b |
        message: po.message,
        first_occurred_at: po.occurred_at,
        last_occurred_at: fragment("(SELECT MAX(occurred_at) FROM occurrences WHERE bug_id = ? AND environment_id = ?) AS last_occurred_at", b.id, ^environment.id),
        occurrences_count: fragment("(SELECT count(1) FROM occurrences WHERE bug_id = ? AND environment_id = ?) AS occurrences_count", b.id, ^environment.id)
      }
  end
end
