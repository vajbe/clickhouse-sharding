CREATE DATABASE IF NOT EXISTS test_db;

CREATE TABLE
    test_db.events ON CLUSTER '{cluster}' (
        event_id UUID DEFAULT generateUUIDv4 (),
        event_time DateTime DEFAULT now (),
        user_id UInt32,
        event_type String
    ) ENGINE = ReplicatedMergeTree ('/clickhouse/tables/{shard}/events', '{replica}')
PARTITION BY
    toYYYYMM (event_time)
ORDER BY
    (event_time, user_id);