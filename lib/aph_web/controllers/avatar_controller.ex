defmodule AphWeb.AvatarController do
  use AphWeb, :controller

  alias Aph.Main
  alias Aph.Main.Avatar

  action_fallback AphWeb.FallbackController

  def index(conn, _params) do
    avatars = Main.list_avatars()
    render(conn, "index.json", avatars: avatars)
  end

  def create(conn, %{
        "name" => name,
        "pitch" => pitch,
        "speed" => speed,
        "language" => language,
        "gender" => gender,
        "pic1" => pic1,
        "pic2" => pic2
      }) do
    with {:ok, %Avatar{} = avatar} <-
           Main.create_avatar(
             %{name: name, pitch: pitch, speed: speed, language: language, gender: gender},
             pic1,
             pic2
           ) do
      conn
      |> put_status(:created)
      |> render("show.json", avatar: avatar)
    end
  end

  def show(conn, %{"id" => id}) do
    avatar = Main.get_avatar(id)
    render(conn, "show.json", avatar: avatar)
  end

  def update(conn, %{"id" => id, "avatar" => avatar_params}) do
    avatar = Main.get_avatar!(id)

    with {:ok, %Avatar{} = avatar} <- Main.update_avatar(avatar, avatar_params) do
      render(conn, "show.json", avatar: avatar)
    end
  end

  def delete(conn, %{"id" => id}) do
    avatar = Main.get_avatar!(id)

    with {:ok, %Avatar{}} <- Main.delete_avatar(avatar) do
      send_resp(conn, :no_content, "")
    end
  end
end
