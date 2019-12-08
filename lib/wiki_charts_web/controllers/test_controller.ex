defmodule WikiChartsWeb.TestController do
  use WikiChartsWeb, :controller

  def index(conn, _params) do
    count = WikiCharts.Repo.aggregate(WikiCharts.User, :count, :id)
    json(conn, %{count: count})
  end
end
