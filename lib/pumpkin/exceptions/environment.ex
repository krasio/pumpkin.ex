defmodule Pumpkin.Exceptions.Environment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pumpkin.Exceptions.Environment
  alias Pumpkin.Exceptions.Occurrence


  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "environments" do
    has_many :occurrences, Occurrence
    timestamps()
  end

  @doc false
  def changeset(%Environment{} = environment, attrs) do
    environment
    |> cast(attrs, [:id])
    |> validate_required([:id])
    |> unique_constraint(:id, name: :environments_pkey)
  end
end
