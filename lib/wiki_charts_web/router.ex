defmodule WikiChartsWeb.Router do
  use WikiChartsWeb, :router

  pipeline :test do
    plug :accepts, ["json"]
  end

  pipeline :api do
    if Mix.env() == :dev do
      plug CORSPlug, origin: "*"
    else
      plug CORSPlug, origin: "https://www.wikinalysis.com"
    end

    plug :accepts, ["json"]
  end

  # Diagnostic endpoints
  scope "/", WikiChartsWeb do
    pipe_through :test
    get "/", TestController, :index
    get "/database", TestController, :database
  end

  scope "/api", WikiChartsWeb do
    pipe_through :api
    get "/wikis/current", WikiController, :current
    resources "/wikis", WikiController, only: [:index]

    get "/revisions/select", GraphController, :revision_select
    get "/pages/select", GraphController, :page_select

    resources "/revisions", RevisionController, only: [:index, :show]
    resources "/pages", PageController, only: [:index, :show]
  end
end
