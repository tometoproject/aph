defmodule Aph.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :plain_password, :string, virtual: true
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :plain_password])
    |> validate_required([:email, :username, :plain_password])
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}$/)
    |> validate_length(:plain_password, min: 6)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_hashed_password
  end

  defp put_hashed_password(%Ecto.Changeset{valid?: true, changes: %{plain_password: password}} = changeset) do
    put_change(changeset, :password, Argon2.add_hash(password).password_hash)
  end

  defp put_hashed_password(changeset), do: changeset
end
