defmodule WikiCharts.Graph do
  import Ecto.Query, warn: false
  alias WikiCharts.Repo
  alias WikiCharts.Wiki.{Revision, Page}

  def revision_select(language, field) do
    fields = [:id, :language, field]

    query =
      from r in Revision,
        where: r.language == ^language,
        where: r.is_latest == true,
        select: map(r, ^fields)

    Repo.all(query)
  end

  def page_select(language, field) do
    fields = [:id, :language, field]

    query =
      from p in Page,
        where: p.language == ^language,
        select: map(p, ^fields)

    Repo.all(query)
  end
end
