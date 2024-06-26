# Привести 2 - 3 практических примера использования БД ClickHouse в компаниях

## **1. go-graphite**

https://github.com/go-graphite

Бекэнд для обработки метрик в формате Gtaphite и хранения метрик в Clickhouse.


Использовался в компании "Тензор" в качестве основной системы мониторинга системных и безнес метрик.

Clichouse отлично подходит для храниния временных рядов, коими являются серии метрик.

Использовались движки семейства MergeTree:
1. ReplicatedGraphiteMergeTree - позволяет провоить retention по определенным условиям, для агрегации метрик.
2. ReplicatedReplacingMergeTree - позволяет хранить справочники тегов с дедупликацией.
   
## **2. BI на основе Clickhouse + Clickhouse Datasource Plugin + Grafana**

https://habr.com/ru/companies/ozontech/articles/774712/

Clickhouse Datasource Plugin позволяет выбирать данные из Clickhouse в Grafana прямыми запросами в БД.

Имеем все приимущества графаны:

1. Графики читаемы и интуитивно понятны — у пользователя не возникает вопросов о том, на какие данные он смотрит.

2. Дашборд и графики грузятся стабильно и быстро.

3. Одни и те же данные согласуются между разными дашбордами. Значения одних и тех же показателей не различаются между дашбордами.

Не требуется дополнительных бекэндов для предоставления данных в систему визуализации.

# Ответы на вопросы из лекции:

## **1. К каким классам систем относится ClickHouse?**

ClickHouse — столбцовая система управления базами данных (СУБД) для онлайн-обработки аналитических запросов (OLAP).

## **2. Какую проблему вы бы решили используя ClickHouse, а какую бы не стали?**

Хорошо подходит для решения аналитических задач, которые требуют выборку из больших массивов данных с агрегацией. 

Не очень подходит для транзакционных задач, которые подразумевают модификацию и нормализацию данных. 

## **3. Где можно получить помощь по ClickHouse и куда сообщать о багах?**

Основной источник с документацией https://clickhouse.com/docs/en/intro

Сообщать о багах можно создавая issue на GitHub проекте Clickhouse https://github.com/ClickHouse/ClickHouse

Так же можно пользоваться телеграм каналоми или форумами