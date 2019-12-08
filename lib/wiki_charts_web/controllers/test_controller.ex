defmodule WikiChartsWeb.TestController do
  use WikiChartsWeb, :controller

  def index(conn, _params) do
    text(conn, "Everything is running!")
  end

  def database(conn, _params) do
    count = WikiCharts.Repo.aggregate(WikiCharts.User, :count, :id)
    text(conn, "The database is active, there are " <> Integer.to_string(count) <> " users.")
  end
end
