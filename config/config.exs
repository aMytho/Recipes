# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :recipebook,
  ecto_repos: [Recipebook.Repo]

# Configures the endpoint
config :recipebook, RecipebookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PldE6eV/+UGEgAuqGM2jKQjH6jfebZWp7F8EPgZPodgH4xl43CjJQJSwr8ngvYwz",
  render_errors: [view: RecipebookWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Recipebook.PubSub,
  live_view: [signing_salt: "PLztwOoA"]

config :recipebook,
  uploads_directory: System.get_env("POETIC_UPLOADS_DIRECTORY") || "/uploads"
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
