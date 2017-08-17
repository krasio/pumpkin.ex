# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pumpkin,
  ecto_repos: [Pumpkin.Repo]

# Configures the endpoint
config :pumpkin, PumpkinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ETs/pX8l8Hj/+tNCpiiRezHDOiKdFP3t1uHJ0bdR27HVlxpWYxW6LNBToNdWbifM",
  render_errors: [view: PumpkinWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pumpkin.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :pumpkin, :generators,
  binary_id: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
