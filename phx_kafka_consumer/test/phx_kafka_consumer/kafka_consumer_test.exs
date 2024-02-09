defmodule KafkaConsumerTest do
  use ExUnit.Case, async: true

  alias PhxKafkaConsumer.KafkaConsumer

  @message_sample %{
    "message" => "Hello, World!",
    "amount" => 100
  }

  test "test message" do
    ref = Broadway.test_message(KafkaConsumer, @message_sample)
    assert_receive {:ack, ^ref, [%{data: @message_sample}], []}
  end

  test "batch messages" do
    ref = Broadway.test_batch(KafkaConsumer, [1, @message_sample], batch_mode: :bulk)
    assert_receive {:ack, ^ref, [%{data: 1}, %{data: @message_sample}], []}, 2000
  end
end
