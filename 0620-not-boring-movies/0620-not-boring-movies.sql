# Write your MySQL query statement below

Select id, movie, description, rating
From Cinema
WHERE id % 2 != 0
AND description != 'boring'
ORDER BY rating DESC