defmodule WikiCharts.Wiki.ActiveWiki do
  use Ecto.Schema

  @primary_key {:id, :string, []}
  @derive {Phoenix.Param, key: :id}
  schema "current_wikis" do
    field :language_name, :string
    field :language_local, :string
    field :article_count, :integer
    field :admin_count, :integer
    field :user_count, :integer
    field :active_user_count, :integer
    field :page_count, :integer
    field :edit_count, :integer
    field :image_count, :integer
    field :depth, :float
  end
end
