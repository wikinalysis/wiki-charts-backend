defmodule WikiChartsWeb.RevisionController do
  use WikiChartsWeb, :controller

  alias WikiCharts.Wiki

  action_fallback WikiChartsWeb.FallbackController

  def index(conn, %{"language" => language}) do
    revisions = Wiki.list_revisions(language)
    render(conn, "index.json", revisions: revisions)
  end

  def show(conn, %{"id" => id}) do
    with %Wiki.Revision{} = revision <- Wiki.get_revision(id) do
      render(conn, "show.json", revision: revision)
    end
  end
end
