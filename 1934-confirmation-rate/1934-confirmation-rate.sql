# Write your MySQL query statement below
With CTE AS (
SELECT S.user_id, C.time_stamp, action
from signups S 
left join confirmations C
on S.user_id = C.user_id
),
TOTAL AS (
# 아이디별 전체 개수
SELECT user_id, count(*) as totalCnt
FROM CTE
GROUP BY user_id
),
PART AS (
# 아이디별 confirmed 개수
SELECT user_id, count(*) as confirmedCnt
FROM CTE
where action = 'confirmed'
GROUP BY user_id
)

Select T.user_id, round(ifnull(confirmedCnt,0)/totalCnt, 2) as confirmation_rate
from TOTAL T
LEFT JOIN PART P
ON T.user_id = P.user_id


