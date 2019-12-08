defmodule WikiChartsWeb.WikiController do
  use WikiChartsWeb, :controller

  alias WikiCharts.Wiki

  action_fallback WikiChartsWeb.FallbackController

  def index(conn, _params) do
    wikis = Wiki.list_wikis()
    render(conn, "index.json", wikis: wikis)
  end
end
