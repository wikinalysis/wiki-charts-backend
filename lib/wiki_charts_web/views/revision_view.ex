defmodule WikiChartsWeb.RevisionView do
  use WikiChartsWeb, :view
  alias WikiChartsWeb.RevisionView
  alias WikiChartsWeb.PageView

  def render("index.json", %{revisions: revisions}) do
    %{data: render_many(revisions, RevisionView, "revision.json")}
  end

  def render("show.json", %{revision: revision}) do
    %{data: render_one(revision, RevisionView, "revision.json")}
  end

  def render("revision.json", %{revision: revision}) do
    case revision do
      %{page: %WikiCharts.Wiki.Page{}} ->
        %{
          id: revision.id,
          wiki_id: revision.wiki_id,
          page_id: revision.page_id,
          language: revision.language,
          text_length: revision.text_length,
          sha1: revision.sha1,
          created_at: revision.created_at,
          revision_number: revision.revision_number,
          is_first: revision.is_first,
          is_latest: revision.is_latest,
          page: render_one(revision.page, PageView, "page.json")
        }

      _ ->
        %{
          id: revision.id,
          wiki_id: revision.wiki_id,
          page_id: revision.page_id,
          language: revision.language,
          text_length: revision.text_length,
          sha1: revision.sha1,
          created_at: revision.created_at,
          revision_number: revision.revision_number,
          is_first: revision.is_first,
          is_latest: revision.is_latest
        }
    end
  end
end
