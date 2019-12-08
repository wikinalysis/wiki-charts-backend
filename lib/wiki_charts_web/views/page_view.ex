defmodule WikiChartsWeb.PageView do
  use WikiChartsWeb, :view
  alias WikiChartsWeb.PageView
  alias WikiChartsWeb.RevisionView

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, PageView, "page.json")}
  end

  def render("show.json", %{page: page}) do
    %{data: render_one(page, PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    case page do
      %{first: %WikiCharts.Wiki.Revision{}, latest: %WikiCharts.Wiki.Revision{}} ->
        %{
          id: page.id,
          wiki_id: page.wiki_id,
          language: page.language,
          title: page.title,
          revision_count: page.revision_count,
          latest_id: page.latest_id,
          first_id: page.first_id,
          first: render_one(page.first, RevisionView, "revision.json"),
          latest: render_one(page.latest, RevisionView, "revision.json"),
          revisions: render_many(page.revisions, RevisionView, "revision.json")
        }

      _ ->
        %{
          id: page.id,
          wiki_id: page.wiki_id,
          language: page.language,
          title: page.title,
          revision_count: page.revision_count,
          latest_id: page.latest_id,
          first_id: page.first_id
        }
    end
  end
end
