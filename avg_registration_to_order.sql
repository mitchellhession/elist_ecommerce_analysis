-- Created CTE to calculate days to purchase.
-- Calculated days to purchase by taking date difference of account created date and purchase date.
WITH days_to_purchase_cte AS (
  SELECT 
    customers.id AS customer_id,
    orders.id AS order_id,
    customers.created_on,
    orders.purchase_ts,
    date_diff(orders.purchase_ts, customers.created_on,day) AS days_to_purchase
  FROM `elist.customers` AS customers
  LEFT JOIN elist.orders AS orders
  ON customers.id=orders.customer_id
  ORDER BY 1, 2, 3
)

-- Took the average of the number of days to purchase.
SELECT
  AVG(days_to_purchase)
FROM days_to_purchase_cte;
