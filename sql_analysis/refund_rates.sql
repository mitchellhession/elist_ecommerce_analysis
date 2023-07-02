-- Counted the number of refunds per month (non-null refund date) and calculate the refund rate.
-- Refund rate is equal to the total number of refunds divided by the total number of orders.
SELECT
  DATE_TRUNC(orders.purchase_ts, MONTH) AS month,
  SUM(CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refunds,
  SUM(CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END)/COUNT(DISTINCT orders.id) * 100 AS refund_rate
FROM `elist.orders` AS orders
-- Joined to order_status table.
LEFT JOIN `elist.order_status` AS order_status
  USING (id)
-- Grouped and ordered by date.
GROUP BY 1
ORDER BY 1 DESC;

SELECT
  DATE_TRUNC(order_status.refund_ts, MONTH) AS month,
  SUM(CASE WHEN order_status.refund_ts IS NOT NULL THEN 1 ELSE 0 END) AS refunds
FROM `elist.orders` AS orders
LEFT JOIN `elist.order_status` AS order_status
  USING (id)
-- Filtered for year 2021 and "apple" product name.
WHERE EXTRACT(YEAR FROM order_status.refund_ts) = 2021
AND LOWER(orders.product_name) LIKE '%apple%'
GROUP BY 1
ORDER BY 1;
