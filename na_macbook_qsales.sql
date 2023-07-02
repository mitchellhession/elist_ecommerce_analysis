-- Selected quarter, region, number of orders, total sales, and average order value. Rounded numbers for readability.
SELECT 
  DATE_TRUNC(orders.purchase_ts, QUARTER) AS purchase_quarter,
  geo_lookup.region,
  COUNT(DISTINCT orders.id) AS order_count,
  ROUND(SUM(orders.usd_price),2) AS total_sales,
  ROUND(AVG(orders.usd_price),2) AS aov
FROM elist.orders AS orders
-- Joined to customers and geo_lookup tables.
LEFT JOIN elist.customers AS customers
  ON orders.customer_id=customers.id
LEFT JOIN elist.geo_lookup AS geo_lookup
  ON customers.country_code=geo_lookup.country
--Filtered for only North America and Macbooks.
WHERE LOWER(orders.product_name) LIKE '%macbook%'
AND region = 'NA'
-- Grouped by quarter and region. Organized by quarter and region.
GROUP BY 1,2
ORDER BY 1 DESC, 2;
