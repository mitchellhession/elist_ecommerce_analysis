-- Calculated the total number of orders and total sales by region and registration channel.
WITH region_orders AS (
  SELECT 
    geo_lookup.region,
    customers.marketing_channel,
    COUNT(DISTINCT orders.id) AS num_orders,
    SUM(orders.usd_price) AS total_sales,
    AVG(orders.usd_price) AS aov
  FROM elist.orders AS orders
-- Joined to customers table and geo_lookup table.
  LEFT JOIN elist.customers AS customers
    ON orders.customer_id=customers.id
  LEFT JOIN elist.geo_lookup AS geo_lookup
    ON customers.country_code=geo_lookup.country
  GROUP BY 1,2
  ORDER BY 1,2
)

-- Ranked the channels by total sales, and order the dataset by this ranking to surface the top channels per region first
SELECT *,
  ROW_NUMBER() OVER (PARTITION BY region ORDER BY num_orders DESC) AS ranking
FROM region_orders
-- Ordered by rank.
ORDER BY 6 ASC
