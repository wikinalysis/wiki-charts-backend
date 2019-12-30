defmodule WikiCharts.Graph do
  import Ecto.Query, warn: false
  alias WikiCharts.Repo
  alias WikiCharts.Wiki.{Revision, Page}

  def histogram(queryable, params) do
    case queryable do
      Page ->
        page_histogram(params)

      Revision ->
        revision_histogram(params)
    end
  end

  def page_histogram(%{language: language, field: field}) do
    query =
      case field do
        :revision_count ->
          """
          SELECT
          FLOOR(revision_count/5.00)*5 as floor,
          FLOOR(revision_count/5.00)*5 + 5 as ceiling,
          COUNT(*) as count
          FROM pages
          WHERE wiki_language = "#{language}"
          GROUP BY 1, 2
          ORDER BY 1;
          """
      end

    case Repo.query(query) do
      {:ok, results} ->
        Enum.map(results.rows, fn r ->
          %{floor: Enum.at(r, 0), ceiling: Enum.at(r, 1), count: Enum.at(r, 2)}
        end)

      {:error, err} ->
        throw(err)
    end
  end

  def revision_histogram(%{language: language, field: field}) do
    query =
      case field do
        :text_length ->
          """
          SELECT
          FLOOR(text_length/500.00)*500 as floor,
          FLOOR(text_length/500.00)*500 + 500 as ceiling,
          COUNT(*) as count
          FROM revisions
          WHERE wiki_language = "#{language}" and is_latest = true
          GROUP BY 1, 2
          ORDER BY 1;
          """

        :created_at ->
          """
          SELECT
          EXTRACT(YEAR_MONTH FROM created_at) as floor,
          PERIOD_ADD(EXTRACT(YEAR_MONTH FROM created_at), 1) as ceiling,
          COUNT(*) as count
          FROM revisions
          WHERE wiki_language = "#{language}" AND is_latest = true
          GROUP BY 1, 2
          ORDER BY 1;
          """
      end

    case Repo.query(query) do
      {:ok, results} ->
        Enum.map(results.rows, fn r ->
          %{floor: Enum.at(r, 0), ceiling: Enum.at(r, 1), count: Enum.at(r, 2)}
        end)

      {:error, err} ->
        throw(err)
    end
  end

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
