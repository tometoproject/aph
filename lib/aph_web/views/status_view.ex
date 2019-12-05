defmodule AphWeb.StatusView do
  use AphWeb, :view
  alias AphWeb.StatusView

  def render("index.json", %{statuses: statuses}) do
    %{data: render_many(statuses, StatusView, "status.json")}
  end

  def render("show.json", %{status: status}) do
    %{data: render_one(status, StatusView, "status.json")}
  end

  def render("status.json", %{status: status}) do
    %{id: status.id, content: status.content}
  end
end
