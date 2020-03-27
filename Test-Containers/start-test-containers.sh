#!/bin/sh

docker-compose -f test-containers-docker-compose.yml up -d

# Setup Couchbase:
# Repeat several times to retry in case of some errors
for ((i = 0; i < 3; i++)); do
  sleep 5s
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/pools/default -d memoryQuota=256 -d indexMemoryQuota=256 -d ftsMemoryQuota=256
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/pools/default/buckets -d name=Administrator -d bucketType=couchbase -d flushEnabled=1 -d ramQuotaMB=100 -d replicaNumber=0 -d replicaIndex=0 -d authType=sasl -d saslPassword=password
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/settings/indexes -d storageMode=forestdb
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/nodes/self/controller/settings -d path=/tmp/couchbase_data -d index_path==/tmp/couchbase_index
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/node/controller/setupServices -d services=kv,index,n1ql,fts
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8091/settings/web -d username=Administrator -d password=password -d port=SAME
  docker exec offers-service-functional-tests_couchbase_1 curl -X POST -u Administrator:password http://127.0.0.1:8093/query?statement=CREATE+PRIMARY+INDEX+ON+Administrator
  docker exec offers-service-functional-tests_couchbase_1 curl -X PUT -u Administrator:password http://127.0.0.1:8091/settings/rbac/users/local/Administrator -d roles=bucket_full_access%Administrator%5D -d name= -d password=password
done;

# Setup Kafka:
# Create topics:
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic offer_history --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic zipkin --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic template_history --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic trigger_history --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic offer_user_trigger_history --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic payment --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic session --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic user_messages --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec offers-service-functional-tests_kafka_1 /usr/bin/kafka-topics --create --topic delete_offer --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181