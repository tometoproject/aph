defmodule Aph.Main.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :content, :string
    field :avatar_id, :id
    field :related_status_id, :id

    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
