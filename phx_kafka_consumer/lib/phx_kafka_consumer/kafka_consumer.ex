defmodule PhxKafkaConsumer.KafkaConsumer do
  use Broadway

  require Logger

  def start_link(_opts) do
    config =
      Application.get_env(
        :phx_kafka_consumer,
        :kafka_broker
      )

    case config[:enabled] do
      true ->
        Logger.info("Starting kafka consumer")

        Broadway.start_link(__MODULE__,
          name: __MODULE__,
          producer: [
            module:
              {BroadwayKafka.Producer,
               hosts: config[:kafka_host],
               group_id: config[:group_name],
               topics: config[:topic],
               client_config: config[:client_config]}
          ],
          processors: [
            default: [concurrency: config[:concurrency]]
          ],
          batchers: [
            default: config[:consumer_batcher]
          ]
        )

      false ->
        Logger.info("#{__MODULE__} will not be initialized because it's disabled.")
        :ignore
    end
  end

  @impl true
  def handle_message(_, message, _) do
    IO.inspect(message.data, label: "Got message")
    message
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    messages
  end
end
