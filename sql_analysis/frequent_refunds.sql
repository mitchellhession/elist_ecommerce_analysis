-- Cleaned up product name.
-- Calculate refund rate across products.
--order in descending order of refund rate to get the top 3 frequently refunded
SELECT
  CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4k gaming monitor' ELSE product_name END AS product_clean,
  SUM(CASE WHEN refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refunds,
  SUM(CASE WHEN refund_ts IS NOT NULL THEN 1 ELSE 0 END)/COUNT(DISTINCT orders.id) * 100 AS refund_rate
FROM `elist.orders` AS orders
-- Joined to order_status table.
LEFT JOIN `elist.order_status` AS order_status
  USING (id)
GROUP BY 1
-- Ordered in descending order of refund rate to get the top 3 frequently refunded.
ORDER BY 3;

SELECT
  CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4k gaming monitor' ELSE product_name END AS product_clean,
  SUM(CASE WHEN refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refunds,
  SUM(CASE WHEN refund_ts IS NOT NULL THEN 1 ELSE 0 END)/COUNT(DISTINCT orders.id) * 100 AS refund_rate
FROM `elist.orders` AS orders
LEFT JOIN `elist.order_status` AS order_status
  USING (id)
GROUP BY 1
-- Ordered by count of refunds.
ORDER BY 2 DESC;
