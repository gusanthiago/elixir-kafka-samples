defmodule PhxKafkaConsumer.KafkaConsumer do
  use Broadway

  require Logger

  def start_link(_opts) do
    config =
      Application.get_env(
        :phx_kafka_consumer,
        :kafka_broker
      )

    Logger.info("Start kafka consumer")

    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {config[:producer_module],
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
