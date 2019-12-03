defmodule AphWeb.ErrorView do
  use AphWeb, :view

  def render(:"404", _assigns) do
    %{message: "Not found!"}
  end

  def render(:"401", _assigns) do
    %{message: "Unauthorized!"}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
