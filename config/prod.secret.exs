# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

# CHANGES TO THIS FILE WILL NOT BE REFLECTED IN GIT
# git update-index --assume-unchanged ./config/prod.secret.exs
connection_name = System.fetch_env!("INSTANCE_CONNECTION_NAME")
database_username = System.fetch_env!("DB_USERNAME")
database_password = System.fetch_env!("DB_PASSWORD")
database_database = System.fetch_env!("DB_DATABASE")
secret_key_base = System.fetch_env!("SECRET_BASE_KEY")

config :wiki_charts, WikiCharts.Repo,
  # ssl: true,
  username: database_username,
  password: database_password,
  database: database_database,
  socket: "/tmp/cloudsql/" <> connection_name,
  pool_size: 10

config :wiki_charts, WikiChartsWeb.Endpoint, secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :wiki_charts, WikiChartsWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
