defmodule WikiChartsWeb.Router do
  use WikiChartsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WikiChartsWeb do
    pipe_through :api
  end
end
