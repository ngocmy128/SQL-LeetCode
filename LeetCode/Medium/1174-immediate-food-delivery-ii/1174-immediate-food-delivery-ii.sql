-- Write your PostgreSQL query statement below
WITH CTE_first_order AS
(SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id),
CTE_immediate_delivery AS
(SELECT d.customer_id, f.first_order_date, d.order_date, d.customer_pref_delivery_date
FROM CTE_first_order f
LEFT JOIN Delivery d
ON f.customer_id = d.customer_id
WHERE d.order_date = f.first_order_date)

SELECT ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)*100,2) AS immediate_percentage
FROM CTE_immediate_delivery 