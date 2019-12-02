defmodule AphWeb.Router do
  use AphWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AphWeb do
    pipe_through :api
  end
end
