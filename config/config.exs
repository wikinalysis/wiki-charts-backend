# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wiki_charts,
  ecto_repos: [WikiCharts.Repo]

# Configures the endpoint
config :wiki_charts, WikiChartsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "maJuz4dd/f5/8hqQ7m2Vm5WR74B186+5PWs541mFr7zDXqhWKUh/8c2VFi5Iaqou",
  render_errors: [view: WikiChartsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: WikiCharts.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix, :format_encoders, json: WikiChartsWeb.JSONEncoder

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
