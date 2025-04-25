-- Write your PostgreSQL query statement below
SELECT person_name FROM 
(SELECT 
    person_name,
    SUM(Weight) OVER (ORDER BY Turn) as total_weight
FROM Queue)
WHERE total_weight <= 1000 
ORDER BY total_weight DESC
LIMIT 1
