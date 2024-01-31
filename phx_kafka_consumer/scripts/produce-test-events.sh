for x in {1..1000}; do echo "{\"message\":\"$x\"}"; sleep 0.1; done | docker exec -i kafka kafka-console-producer --topic consumer.test-topic --broker-list localhost:9092 

# Consume to test
# docker exec -i kafka kafka-console-consumer --topic consumer.test-topic --bootstrap-server localhost:9092 --from-beginning
