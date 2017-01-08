defmodule Decoction.Router do
  use Decoction.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Decoction do
    pipe_through [:browser, :session]

    get "/", PageController, :index
    resources "/users", UserController

    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
    get "/logout", SessionController, :delete, as: :logout
    delete "/logout", SessionController, :delete, as: :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Decoction do
  #   pipe_through :api
  # end
end
