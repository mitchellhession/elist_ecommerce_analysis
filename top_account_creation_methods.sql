-- AOV and count of new customers by account creation channel in first 2 months of 2022.
SELECT 
  customers.account_creation_method,
  AVG(usd_price) as aov,
  COUNT(DISTINCT customer_id) AS num_customers
FROM `elist.orders` AS orders
-- Joined to customers table.
LEFT JOIN `elist.customers` AS customers
  ON orders.customer_id=customers.id
-- Filtered for account creation in January and Febraury of 2022.
WHERE created_on BETWEEN '2022-01-01' and '2022-02-28'
-- Grouped by account creation method. Ordered by count of customers.
GROUP BY 1
ORDER BY 3 DESC;
