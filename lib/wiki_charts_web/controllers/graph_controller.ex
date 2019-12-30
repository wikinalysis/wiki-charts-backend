defmodule WikiChartsWeb.GraphController do
  use WikiChartsWeb, :controller

  alias WikiCharts.Graph

  action_fallback WikiChartsWeb.FallbackController

  @revision_fields [:created_at, :text_length]
  @page_fields [:revision_count]
  @languages ~w(ltg pih rmy sco tn)

  def pages(conn, params) do
    histogram(conn, params)
  end

  def revisions(conn, params) do
    histogram(conn, params)
  end

  # We're doing a terrible thing here, BOTH of these values are directly
  # injecting into a RAW SQL statement. For now, we're going to force check
  # the values against a set of whitelists. :(
  # Learning the right way to do this in ecto, or the right way to interpolate
  # into SQL, is my top priority
  defp histogram(conn, %{"language" => language, "field" => field}) when language in @languages do
    case String.to_atom(ProperCase.snake_case(field)) do
      f when f in @page_fields ->
        data = Graph.histogram(WikiCharts.Wiki.Page, %{language: language, field: f})
        render(conn, "histogram.json", data: data)

      f when f in @revision_fields ->
        data = Graph.histogram(WikiCharts.Wiki.Revision, %{language: language, field: f})
        render(conn, "histogram.json", data: data)

      _ ->
        error(conn)
    end
  end

  defp histogram(conn, _params) do
    error(conn)
  end

  defp error(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(WikiChartsWeb.ErrorView)
    |> render(:"404")
  end
end
