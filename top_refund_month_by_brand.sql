-- Created brand categories and filter to 2020.
-- Counted the number of refunds per month.
WITH brand_refunds AS (
  SELECT
    CASE WHEN LOWER(product_name) LIKE '%apple%' OR LOWER(product_name) LIKE '%macbook%' THEN 'Apple'
      WHEN LOWER(product_name) LIKE '%thinkpad%' THEN 'ThinkPad'
      WHEN LOWER(product_name) LIKE '%samsung%' THEN 'Samsung'
      WHEN LOWER(product_name) LIKE '%bose%' THEN 'Bose'
      ELSE 'unknown'
    END AS brand,
    DATE_TRUNC(refund_ts, MONTH) AS refund_month,
    COUNT(refund_ts) AS refunds
  FROM `elist.orders` AS orders
-- Joined to order_status table.
  LEFT JOIN elist.order_status
    USING (id)
-- Filtered for refunds in 2020.
  WHERE EXTRACT(YEAR FROM refund_ts) = 2020
  GROUP BY 1,2
)

-- Selected the month per brand based on the highest number of refunds.
SELECT *
FROM brand_refunds
QUALIFY ROW_NUMBER() OVER (PARTITION BY brand ORDER BY refunds DESC) = 1;
