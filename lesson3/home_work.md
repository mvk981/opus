### 1.
SELECT count()
FROM trips
WHERE payment_type = 1

Query id: 5f708b91-2196-460c-8abb-318458425b4c

 │ 1850287 │ -- 1.85 million

1 row in set. Elapsed: 0.010 sec. Processed 3.00 million rows, 3.00 MB (311.72 million rows/s., 311.72 MB/s.)

### 2.

Нагрузочное тестирование проводилось скриптом ***hardware.sh***

Результаты в файле ***bench.pdf***