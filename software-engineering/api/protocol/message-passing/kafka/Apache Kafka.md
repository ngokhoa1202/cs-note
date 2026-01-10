#messaging #kafka #event-streaming #distributed-systems #log-based
==Apache Kafka== is a distributed event streaming platform designed for high-throughput, fault-tolerant, and scalable data pipelines. Unlike traditional message brokers, Kafka persists messages in a distributed commit log, enabling event replay and stream processing.

## Architecture

```mermaid
graph TD
    P1[Producer 1] -->|write| T[Topic: orders]
    P2[Producer 2] -->|write| T
    T -->|P0| B1[Broker 1]
    T -->|P1| B2[Broker 2]
    T -->|P2| B3[Broker 3]
    B1 --> CG1[Consumer Group A]
    B2 --> CG1
    B3 --> CG1
    B1 --> CG2[Consumer Group B]
    B2 --> CG2
    B3 --> CG2

    style T fill:#ff9,stroke:#333
    style B1 fill:#9cf,stroke:#333
    style B2 fill:#9cf,stroke:#333
    style B3 fill:#9cf,stroke:#333
```

### Core Components

- **Broker**: Kafka server that stores and serves messages
- **Topic**: Logical category for organizing messages
- **Partition**: Ordered, immutable sequence of records within a topic
- **Producer**: Client that publishes records to topics
- **Consumer**: Client that subscribes to topics and processes records
- **Consumer Group**: Set of consumers that coordinate to consume partitions
- **ZooKeeper/KRaft**: Cluster coordination and metadata management

## Topics and Partitions

```mermaid
graph TD
    subgraph Topic: user-events
        P0[Partition 0<br/>Leader: B1]
        P1[Partition 1<br/>Leader: B2]
        P2[Partition 2<br/>Leader: B3]
    end

    P0 -.->|replica| B2
    P0 -.->|replica| B3
    P1 -.->|replica| B1
    P1 -.->|replica| B3
    P2 -.->|replica| B1
    P2 -.->|replica| B2

    style P0 fill:#9f9,stroke:#333
    style P1 fill:#9f9,stroke:#333
    style P2 fill:#9f9,stroke:#333
```

### Partitioning Strategy

- **Key-based**: Records with same key route to same partition (maintains ordering per key)
- **Round-robin**: Distributes evenly when key is null
- **Custom partitioner**: Application-specific routing logic

```Java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

Producer<String, String> producer = new KafkaProducer<>(props);
ProducerRecord<String, String> record =
    new ProducerRecord<>("orders", "user-123", orderJson);
producer.send(record);
```

## Consumer Groups

```mermaid
graph LR
    subgraph Topic Partitions
        P0[P0]
        P1[P1]
        P2[P2]
        P3[P3]
    end

    subgraph Consumer Group
        C1[Consumer 1]
        C2[Consumer 2]
    end

    P0 --> C1
    P1 --> C1
    P2 --> C2
    P3 --> C2

    style P0 fill:#9f9,stroke:#333
    style P1 fill:#9f9,stroke:#333
    style P2 fill:#9cf,stroke:#333
    style P3 fill:#9cf,stroke:#333
```

Consumers within same group coordinate to consume partitions. Each partition consumed by exactly one consumer in the group, enabling parallelism and load balancing.

```Java
Properties props = new Properties();
props.put("bootstrap.servers", "localhost:9092");
props.put("group.id", "order-processor");
props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");

KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);
consumer.subscribe(Arrays.asList("orders"));

while (true) {
    ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
    for (ConsumerRecord<String, String> record : records) {
        processOrder(record.value());
    }
    consumer.commitSync();
}
```

## Offset Management

```mermaid
graph LR
    subgraph Partition
        M0[Offset 0]
        M1[Offset 1]
        M2[Offset 2]
        M3[Offset 3]
        M4[Offset 4]
    end

    M0 --> M1 --> M2 --> M3 --> M4

    C[Consumer] -.->|current offset: 3| M3
    LC[Last Committed] -.->|offset: 2| M2

    style M3 fill:#9f9,stroke:#333
    style M2 fill:#ff9,stroke:#333
```

==Offset== is the sequential ID of each record within partition. Consumers track position to enable resumption and replay.

### Commit Strategies

- **Auto-commit**: Periodic automatic offset commits (may duplicate processing)
- **Manual sync commit**: Explicit blocking commit after processing
- **Manual async commit**: Non-blocking commit with callback

```Java
// Manual sync commit
consumer.commitSync();

// Manual async commit
consumer.commitAsync((offsets, exception) -> {
    if (exception != null) {
        log.error("Commit failed", exception);
    }
});
```

## Delivery Guarantees

### At-Most-Once
Enable auto-commit or commit before processing. Fast but may lose messages on consumer failure.

### At-Least-Once
Process then commit. May duplicate messages on consumer failure before commit. Requires idempotent consumers.

### Exactly-Once Semantics (EOS)

```Java
Properties props = new Properties();
props.put("enable.idempotence", "true");
props.put("transactional.id", "order-processor-1");

KafkaProducer<String, String> producer = new KafkaProducer<>(props);
producer.initTransactions();

try {
    producer.beginTransaction();
    producer.send(new ProducerRecord<>("topic", "key", "value"));
    producer.commitTransaction();
} catch (Exception e) {
    producer.abortTransaction();
}
```

Requires idempotent producer and transactional semantics. Prevents duplicates across retries and failures.

## Replication and Fault Tolerance

```mermaid
sequenceDiagram
    participant P as Producer
    participant L as Leader
    participant F1 as Follower 1
    participant F2 as Follower 2

    P->>L: Write record
    L->>F1: Replicate
    L->>F2: Replicate
    F1->>L: ACK
    F2->>L: ACK
    Note over L: All in-sync replicas ACKed
    L->>P: ACK
```

### In-Sync Replicas (ISR)
Replicas that are caught up with leader. Leader waits for ISR acknowledgment based on `acks` configuration.

- **acks=0**: No acknowledgment (fastest, may lose data)
- **acks=1**: Leader acknowledgment only (may lose data if leader fails)
- **acks=all**: All ISR acknowledgment (strongest guarantee)

### Leader Election
When leader fails, one of the ISR replicas is elected as new leader. Ensures no data loss when using `acks=all`.

## Log Retention

```mermaid
graph LR
    subgraph Log Segment
        O1[Old Messages] -->|retention.ms| D[Delete]
        O2[Recent Messages] --> K[Keep]
    end

    style O1 fill:#fcc,stroke:#333
    style O2 fill:#9f9,stroke:#333
```

Kafka retains messages based on time or size policies, independent of consumption.

```Shell
# Time-based retention (7 days)
retention.ms=604800000

# Size-based retention (1GB)
retention.bytes=1073741824

# Compaction - keeps latest value per key
cleanup.policy=compact
```

## Log Compaction

```mermaid
graph TD
    subgraph Before Compaction
        K1A[Key A: v1]
        K2A[Key B: v1]
        K1B[Key A: v2]
        K3A[Key C: v1]
        K2B[Key B: v2]
        K1C[Key A: v3]
    end

    subgraph After Compaction
        K2B2[Key B: v2]
        K3A2[Key C: v1]
        K1C2[Key A: v3]
    end

    style K1C2 fill:#9f9,stroke:#333
    style K2B2 fill:#9f9,stroke:#333
    style K3A2 fill:#9f9,stroke:#333
```

Retains only latest value for each key. Useful for state snapshots and changelog topics.

## Stream Processing (Kafka Streams)

```mermaid
graph LR
    IT[Input Topic] --> SP[Stream Processor]
    SP --> F[Filter]
    F --> M[Map]
    M --> A[Aggregate]
    A --> OT[Output Topic]

    style SP fill:#ff9,stroke:#333
```

Native stream processing library for transformations, aggregations, and joins.

```Java
StreamsBuilder builder = new StreamsBuilder();
KStream<String, String> orders = builder.stream("orders");

orders
    .filter((key, value) -> parseOrder(value).getAmount() > 100)
    .mapValues(value -> processOrder(value))
    .to("high-value-orders");

KafkaStreams streams = new KafkaStreams(builder.build(), props);
streams.start();
```

## Performance Characteristics

### High Throughput
- Sequential disk I/O for log appends
- Zero-copy data transfer from disk to network
- Batch compression and transmission

### Low Latency
- End-to-end latency typically under 10ms
- Optimized for sustained throughput over individual message latency

### Scalability
- Horizontal scaling via partition distribution
- Consumer parallelism through consumer groups
- Linear scaling with broker addition

## Use Cases

### Event Sourcing
Store all state changes as immutable events. Rebuild application state by replaying event log.

### Stream Processing
Real-time data transformations, aggregations, and analytics on event streams.

### Log Aggregation
Centralized collection of application logs from distributed services.

### Metrics and Monitoring
High-throughput ingestion of operational metrics and telemetry data.

### Change Data Capture (CDC)
Track and propagate database changes to downstream systems.

## Kafka Connect

Framework for integrating Kafka with external systems through connectors.

```mermaid
graph LR
    DB[(Database)] -->|Source Connector| K[Kafka Topic]
    K -->|Sink Connector| S3[S3 Bucket]
    K -->|Sink Connector| ES[Elasticsearch]

    style K fill:#ff9,stroke:#333
```

- **Source connectors**: Import data into Kafka
- **Sink connectors**: Export data from Kafka

## Schema Registry

Centralized schema management for Kafka messages using Avro, Protobuf, or JSON Schema.

```Java
Properties props = new Properties();
props.put("schema.registry.url", "http://localhost:8081");

KafkaAvroSerializer serializer = new KafkaAvroSerializer();
KafkaAvroDeserializer deserializer = new KafkaAvroDeserializer();
```

Ensures producer-consumer compatibility and enables schema evolution.

## Common Pitfalls

### Too Many Partitions
Increases ZooKeeper overhead and recovery time. Start conservatively and scale as needed.

### Ignoring Rebalancing
Frequent rebalances impact consumer performance. Tune `session.timeout.ms` and `max.poll.interval.ms`.

### Not Monitoring Consumer Lag
Growing lag indicates consumers cannot keep up. Scale consumers or optimize processing.

### Improper Key Selection
Poor key distribution causes partition skew. Choose keys that distribute evenly.

***
# References
1. Kafka: The Definitive Guide - Neha Narkhede, Gwen Shapira, Todd Palino - 2nd Edition - 2021 - O'Reilly
   1. Chapter 3: Kafka Producers
   2. Chapter 4: Kafka Consumers
   3. Chapter 6: Reliable Data Delivery
2. https://kafka.apache.org/documentation/
3. Designing Event-Driven Systems - Ben Stopford - 2018 - O'Reilly
4. https://kafka.apache.org/documentation/streams/
5. [[Message broker|Back to Message Broker Overview]]
