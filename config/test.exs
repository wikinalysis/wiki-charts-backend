use Mix.Config

# Configure your database
config :wiki_charts, WikiCharts.Repo,
  username: "root",
  password: "",
  database: "wiki_charts_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wiki_charts, WikiChartsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
