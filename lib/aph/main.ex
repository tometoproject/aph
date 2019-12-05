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

  def list_statuses do
    Repo.all(Status)
  end

  def get_status!(id), do: Repo.get!(Status, id)

  def create_status(user_id, attrs \\ {}) do
    av = Repo.get_by!(Avatar, user_id: user_id)
    changeset = Map.put(attrs, :avatar_id, av.id)
    %Status{}
    |> Status.changeset(changeset)
    |> Repo.insert()
  end

  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  def change_status(%Status{} = status) do
    Status.changeset(status, %{})
  end
end
