-- Created CTE to get customers with over 4 purchases first.
WITH over_4_purchases AS (
  SELECT 
    customer_id,
    COUNT(id)
    FROM `elist.orders` AS orders
    GROUP BY 1
    HAVING (COUNT(id)) >=4
)

-- Ranked customer orders by most recent first.
-- Selected the most recent orders using a qualify statement.
SELECT 
  orders.customer_id,
  orders.product_name,
  orders.purchase_ts,
  ROW_NUMBER() OVER (PARTITION BY orders.customer_id ORDER BY orders.purchase_ts DESC) AS order_ranking
FROM `elist.orders` AS orders
-- Chose only customers who had more than 4 purchases with inner join.
INNER JOIN over_4_purchases
  ON over_4_purchases.customer_id=orders.customer_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY purchase_ts DESC) = 1;
