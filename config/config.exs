# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# General application configuration
config :decoction,
  ecto_repos: [Decoction.Repo]

# Configures the endpoint
config :decoction, Decoction.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yAd0aHJnGoLGxdIMrFfG/0CtmtQJfdnRFrL8vuAJ7KtfdQTOWcIehZ9j692xfz2Y",
  render_errors: [view: Decoction.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Decoction.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
