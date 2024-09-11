CREATE DATABASE metrics on cluster '{cluster}';

---------

CREATE TABLE metrics.graphite_data on cluster '{cluster}'
(

    `Path` String CODEC(ZSTD(3)),
    `Value` Float64 CODEC(Delta(8), LZ4),
    `Time` UInt32 CODEC(Delta(4), LZ4),
    `Date` Date CODEC(Delta(2), LZ4),
    `Timestamp` UInt32 CODEC(Delta(4), LZ4)
)
ENGINE = ReplicatedGraphiteMergeTree('/clickhouse/tables/{shard}/metrics/graphite_data',
 '{host}',
 'graphite_rollup')
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Path, Time)
TTL toDateTime(Time) + INTERVAL 180 DAY DELETE
SETTINGS index_granularity = 8192;

---------

CREATE TABLE metrics.graphite_data_dist  on cluster '{cluster}' 
AS metrics.graphite_data 
ENGINE = Distributed('{cluster}', 'metrics', 'graphite_data', rand());

--------

CREATE TABLE metrics.tagged_data on cluster '{cluster}'
(
    `Path` String CODEC(ZSTD(3)),
    `Value` Float64 CODEC(Gorilla, LZ4),
    `Time` UInt32 CODEC(DoubleDelta, LZ4),
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Timestamp` UInt32 CODEC(DoubleDelta, LZ4)
)
ENGINE = ReplicatedGraphiteMergeTree('/clickhouse/tables/{shard}/metrics/tagged_data',
 '{host}',
 'graphite_rollup')
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Path, Time)
TTL toDateTime(Time) + INTERVAL 180 DAY DELETE
SETTINGS index_granularity = 8192;

---------

CREATE TABLE metrics.tagged_data_dist  on cluster '{cluster}' 
AS metrics.tagged_data 
ENGINE = Distributed('{cluster}', 'metrics', 'tagged_data', rand());


---------

CREATE TABLE metrics.index on cluster '{cluster}'
(
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Level` UInt32 CODEC(DoubleDelta, LZ4),
    `Path` String CODEC(ZSTD(3)),
    `Version` UInt32 CODEC(DoubleDelta, LZ4)
)
ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/metrics/index',
 '{host}',
 Version)
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Level, Path, Date)
TTL toDateTime(Version) + INTERVAL 180 DAY DELETE
SETTINGS index_granularity = 8192;

---------

CREATE TABLE metrics.index_dist on cluster '{cluster}'
AS metrics.index 
ENGINE = Distributed('{cluster}', 'metrics', 'index', rand());

---------

CREATE TABLE metrics.tags on cluster '{cluster}'
(

    `Date` Date CODEC(DoubleDelta, LZ4),
    `Tag1` String CODEC(ZSTD(3)),
    `Path` String CODEC(ZSTD(3)),
    `Tags` Array(String) CODEC(ZSTD(3)),
    `Version` UInt32 CODEC(DoubleDelta, LZ4)
)
ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/metrics/tags',
 '{host}',
 Version)
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Tag1, Path, Date)
TTL toDateTime(Version) + INTERVAL 180 DAY DELETE
SETTINGS index_granularity = 8192;

---------

CREATE TABLE metrics.tags_dist on cluster '{cluster}'
AS metrics.tags 
ENGINE = Distributed('{cluster}', 'metrics', 'tags', rand()); 