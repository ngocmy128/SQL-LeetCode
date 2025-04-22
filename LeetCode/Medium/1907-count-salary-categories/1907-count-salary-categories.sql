-- Write your PostgreSQL query statement below
WITH cat_tbl AS
(SELECT 'Low Salary' AS category
  UNION
  SELECT 'Average Salary'
  UNION
  SELECT 'High Salary'
),
cat_count_tbl AS
(
SELECT category, COUNT(category) AS accounts_count
FROM
    (SELECT 
    account_id, 
    CASE 
        WHEN income < 20000 THEN 'Low Salary'
        WHEN income > 50000 THEN 'High Salary'
        ELSE 'Average Salary'
    END AS category
    FROM Accounts)
GROUP BY category
)

SELECT cat_tbl.category, COALESCE(cat_count_tbl.accounts_count,0) as accounts_count
FROM cat_tbl
LEFT JOIN cat_count_tbl
ON cat_tbl.category = cat_count_tbl.category

