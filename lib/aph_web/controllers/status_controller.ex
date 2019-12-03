defmodule AphWeb.StatusController do
  use AphWeb, :controller

  alias Aph.Main
  alias Aph.Main.Status
  alias Aph.Main.Avatar
  alias AphWeb.Guardian

  action_fallback AphWeb.FallbackController

  def index(conn, _params) do
    statuses = Main.list_statuses()
    render(conn, "index.json", statuses: statuses)
  end

  def create(conn, %{"content" => content, "id" => id}) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)
    with {:ok, other_status} <- Aph.Repo.get_by(Status, id) do
      if other_status.related_status_id do
        conn
        |> put_status(:bad_request)
        |> put_view(AphWeb.ErrorView)
        |> render(:"400")
      end
    end
  end

  def create(conn, %{"content" => content}) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)
    with {:ok, %Status{} = status} <- Main.create_status(content, user_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.status_path(conn, :show, status))
      |> render("show.json", status: status)
    end
  end

  def show(conn, %{"id" => id}) do
    status = Main.get_status!(id)
    render(conn, "show.json", status: status)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
    status = Main.get_status!(id)

    with {:ok, %Status{} = status} <- Main.update_status(status, status_params) do
      render(conn, "show.json", status: status)
    end
  end

  def delete(conn, %{"id" => id}) do
    status = Main.get_status!(id)

    with {:ok, %Status{}} <- Main.delete_status(status) do
      send_resp(conn, :no_content, "")
    end
  end
end
