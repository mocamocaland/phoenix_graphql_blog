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

  scope "/", BlogWeb do
    pipe_through :browser

    get "/", PageController, :index
    # resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
   scope "/api" do
     pipe_through :api

     forward "/graphiql", Absinthe.Plug.GraphiQL,
       schema: BlogWeb.Schema

     forward "/", Absinthe.Plug,
       schema: BlogWeb.Schema
   end
end
