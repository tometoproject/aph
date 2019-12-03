defmodule AphWeb.Router do
  use AphWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :user_auth do
    plug AphWeb.AuthPipeline
  end

  scope "/api", AphWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/register", UserController, :create
    post "/auth", UserController, :login
  end

  scope "/api", AphWeb do
    pipe_through [:api, :user_auth]
    get "/avatar/:id", AvatarController, :show
    post "/avatar/new", AvatarController, :create
  end
end
