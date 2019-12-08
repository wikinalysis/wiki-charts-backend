defmodule WikiCharts.Repo do
  use Ecto.Repo,
    otp_app: :wiki_charts,
    adapter: Ecto.Adapters.MyXQL
end
