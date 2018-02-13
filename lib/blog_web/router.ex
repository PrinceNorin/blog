defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_auth do
    plug Blog.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
    plug BlogWeb.Plugs.SetCurrentUser
  end

  pipeline :ensure_not_auth do
    plug Blog.Auth.Pipeline
    plug Guardian.Plug.EnsureNotAuthenticated
  end

  scope "/", BlogWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", BlogWeb do
    pipe_through [:browser, :ensure_not_auth]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", BlogWeb do
    pipe_through [:browser, :ensure_auth]

    get "/secret", PageController, :secret
    post "/logout", SessionController, :destroy
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogWeb do
  #   pipe_through :api
  # end
end
