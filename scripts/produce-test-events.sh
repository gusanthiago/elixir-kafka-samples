docker exec -i kafka0 kafka-topics --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test-topic
for x in {1..1000}; do echo "{\"message\":\"$x\"}"; sleep 0.1; done | docker exec -i kafka0 kafka-console-producer --topic test-topic --broker-list localhost:9092 

# Consume to test
# docker exec -i kafka kafka-console-consumer --topic consumer.test-topic --bootstrap-server localhost:9092 --from-beginning
