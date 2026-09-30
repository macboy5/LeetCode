# Write your MySQL query statement below

WITH T1 AS (
    SELECT machine_id, SUM(timestamp) AS start_sum, COUNT(*) AS cnt
    FROM Activity
    WHERE activity_type = 'start'
    GROUP BY machine_id
),
T2 AS (
    SELECT machine_id, SUM(timestamp) AS end_sum
    FROM Activity
    WHERE activity_type = 'end'
    GROUP BY machine_id
)
SELECT T1.machine_id,
       ROUND((T2.end_sum - T1.start_sum) / T1.cnt, 3) AS processing_time
FROM T1
JOIN T2 ON T1.machine_id = T2.machine_id;