defmodule Aph.Main do
  import Ecto.Query, warn: false
  alias Aph.Repo

  alias Aph.Main.Avatar

  def list_avatars do
    Repo.all(Avatar)
  end

  def get_avatar(id), do: Repo.get!(Avatar, id)

  def create_avatar(attrs \\ %{}, pic1, pic2) do
    with {:ok, avatar} <- %Avatar{} |> Avatar.changeset(attrs) |> Repo.insert(),
         :ok <- File.cp(pic1.path, elem(avatar_picture_path(avatar.id), 0)),
         :ok <- File.cp(pic2.path, elem(avatar_picture_path(avatar.id), 1)) do
      {:ok, avatar}
    else
      {:error, reason} = error -> error
    end
  end

  def update_avatar(%Avatar{} = avatar, attrs \\ %{}, pic1, pic2) do
    with {:ok, avatar} <- avatar |> Avatar.changeset(attrs) |> Repo.update(),
         :ok <- File.cp(pic1.path, elem(avatar_picture_path(avatar.id), 0)),
         :ok <- File.cp(pic2.path, elem(avatar_picture_path(avatar.id), 1)) do
      {:ok, avatar}
    else
      {:error, reason} = error -> error
    end
  end

  def delete_avatar(%Avatar{} = avatar) do
    Repo.delete(avatar)
  end

  def change_avatar(%Avatar{} = avatar) do
    Avatar.changeset(avatar, %{})
  end

  def avatar_picture_path(id) do
    pic1 = ["priv/static", "av#{id}-1.png"] |> Path.join()
    pic2 = ["priv/static", "av#{id}-2.png"] |> Path.join()
    {pic1, pic2}
  end

  alias Aph.Main.Status

  @doc """
  Returns the list of statuses.

  ## Examples

      iex> list_statuses()
      [%Status{}, ...]

  """
  def list_statuses do
    Repo.all(Status)
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{source: %Status{}}

  """
  def change_status(%Status{} = status) do
    Status.changeset(status, %{})
  end
end
