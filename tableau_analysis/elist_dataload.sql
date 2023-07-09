--select all columns from elist datasets
--clean product name and create time to ship and time to purchase colunmns
select orders.id as order_id,
  orders.customer_id,
  orders.purchase_ts,
  orders.product_id,
  case when lower(product_name) like '%gaming monitor%' then '2in" 4k Gaming Monitor'
    when lower(product_name) = 'bose soundsport headphones' then 'Bose Soundsport Headphones'
    else product_name end as product_name_clean,
  orders.currency,
  orders.local_price,
  orders.usd_price,
  orders.purchase_platform,
  customers.marketing_channel,
  customers.account_creation_method,
  customers.country_code,
  customers.loyalty_program,
  customers.created_on,
  geo_lookup.region,
  order_status.ship_ts,
  order_status.delivery_ts,
  order_status.refund_ts,
  date_diff(order_status.ship_ts, orders.purchase_ts, day) as time_to_ship_days,
  date_diff(order_status.purchase_ts, customers.created_on, day) as time_to_purchase_days
from elist.orders
left join elist.customers
	on orders.customer_id = customers.id
left join elist.geo_lookup
	on geo_lookup.country = customers.country_code
left join elist.order_status
	on order_status.order_id = orders.id
