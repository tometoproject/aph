defmodule AphWeb.StatusView do
  use AphWeb, :view
  alias AphWeb.StatusView

  def render("index.json", %{statuses: statuses}) do
    render_many(statuses, StatusView, "status.json")
  end

  def render("show.json", %{status: status}) do
    render_one(status, StatusView, "status.json")
  end

  def render("status.json", %{status: status}) do
    %{data: status}
  end
end
