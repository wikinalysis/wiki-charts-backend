defmodule WikiChartsWeb.Router do
  use WikiChartsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WikiChartsWeb do
    pipe_through :api
    get "/", TestController, :index
  end

  scope "/api", WikiChartsWeb do
    pipe_through :api
  end
end
