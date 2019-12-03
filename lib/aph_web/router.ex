defmodule AphWeb.Router do
  use AphWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AphWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/register", UserController, :create
    post "/auth", UserController, :login
  end
end
