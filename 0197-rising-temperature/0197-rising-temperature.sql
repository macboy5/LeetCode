# Write your MySQL query statement below

Select w1.id
From Weather w1
Join Weather w2
ON datediff(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature