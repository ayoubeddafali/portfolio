defmodule Portfolio.Router do
  use Portfolio.Web, :router

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

  pipeline :auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", Portfolio do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    post "/works", WorkController, :create
    get "/portfolio", WorkController, :index

    get "/login", PageController, :login
    post "/login", PageController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", Portfolio do
  #   pipe_through :api
  # end
end
