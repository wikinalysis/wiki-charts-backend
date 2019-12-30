defmodule WikiChartsWeb.GraphView do
  use WikiChartsWeb, :view
  alias WikiChartsWeb.GraphView

  def render("histogram.json", %{data: data}) do
    %{meta: create_meta(data), data: data}
  end

  def render("revision_select.json", %{data: data}) do
    %{
      meta: create_meta(data),
      data: render_many(data, GraphView, "map.json")
    }
  end

  def render("page_select.json", %{data: data}) do
    %{
      meta: create_meta(data),
      data: render_many(data, GraphView, "map.json")
    }
  end

  def render("map.json", %{graph: data}) do
    data
  end

  defp create_meta(data) do
    {min, max} = Enum.min_max_by(data, fn d -> d.floor end)
    %{minimum: min.floor, maximum: max.ceiling}
  end
end
