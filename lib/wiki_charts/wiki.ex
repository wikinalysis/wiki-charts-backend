defmodule WikiCharts.Wiki do
  import Ecto.Query, warn: false
  alias WikiCharts.Repo
  alias WikiCharts.Wiki.{Wiki, Revision, Page, ActiveWiki}

  def list_wikis do
    Repo.all(Wiki)
  end

  def list_active_wikis do
    Repo.all(ActiveWiki)
  end

  def list_revisions(language) do
    Revision
    |> where([r], r.language == ^language)
    |> Repo.all()
  end

  def get_revision(id) do
    Revision
    |> preload(:page)
    |> Repo.get(id)
  end

  def list_pages(language) do
    Page
    |> where([r], r.language == ^language)
    |> Repo.all()
  end

  def get_page(id) do
    Page
    |> preload(:first)
    |> preload(:latest)
    |> preload(:revisions)
    |> Repo.get(id)
  end

  # We can't create resources, and shouldn't. But
  # This was generated for us, and may be useful for testing.
  def create_revision(attrs \\ %{}) do
    %Revision{}
    |> Revision.changeset(attrs)
    |> Repo.insert()
  end

  def change_revision(%Revision{} = revision) do
    Revision.changeset(revision, %{})
  end

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end
end
