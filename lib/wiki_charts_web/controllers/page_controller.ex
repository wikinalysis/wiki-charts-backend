defmodule WikiChartsWeb.PageController do
  use WikiChartsWeb, :controller

  alias WikiCharts.Wiki

  action_fallback WikiChartsWeb.FallbackController

  def index(conn, %{"language" => language}) do
    pages = Wiki.list_pages(language)
    render(conn, "index.json", pages: pages)
  end

  def show(conn, %{"id" => id}) do
    with %Wiki.Page{} = page <- Wiki.get_page(id) do
      render(conn, "show.json", page: page)
    end
  end
end
