# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phx_kafka_consumer,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :phx_kafka_consumer, PhxKafkaConsumerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: PhxKafkaConsumerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhxKafkaConsumer.PubSub,
  live_view: [signing_salt: "/RK284RH"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :phx_kafka_consumer, PhxKafkaConsumer.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Kafka Config
config :phx_kafka_consumer, :kafka_broker,
  kafka_host: "localhost:9092",
  topic: ["consumer.test-topic"],
  group_name: "group_test",
  enabled: System.get_env("KAFKA_CONSUMER_ENABLED", "true") |> String.to_atom(),
  client_config: [],
  concurrency: System.get_env("KAFKA_CONCURRENCY", "1") |> String.to_integer(),
  consumer_batcher: [
    batch_size: 10,
    batch_timeout: 1000
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
