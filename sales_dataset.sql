with online_sales as (
select 'Online'::text as sales_channel,
		o.order_id::text as order_id,
		o.order_date::date as order_date,
		o.user_id::text as user_id,
		oi.item_id::text as item_id,
		oi.product_id::text as product_id,
		oi.quantity as quantity,
		p.payment_id::text as payment_id,
		p.payment_method::text as payment_method,
		p.payment_status::text as payment_status,
		pr.product_name::text as product_name,
		pr.product_category::text as product_category,
		pr.product_price as product_price,
		pr.product_brand::text as product_brand,
		pr.model_code::text as model_code,
		pr.weight_kg as weight_kg,
		pr.color::text as color,
		pr.warranty_months  as warranty_months,
		u.user_name::text as user_name,
		u.user_email::text as user_email,
		u.user_city::text as user_city,
		u.user_phone::text as user_phone,
		u.user_age as user_age,
		u.user_gender::text as user_gender,
		u.user_address::text as user_address,
		u.loyalty_status::text as loyalty_status,
		u.account_created::date as account_created,
		s.shipment_id::text as shipment_id,
		s.courier::text as courier,
		s.tracking_number::text as tracking_number,
		s.shipment_date::date as shipment_date,
		s.delivery_date::date as delivery_date,
		s.delivery_status::text as delivery_status
from project.orders_sql_project o
join project.order_items_sql_project oi 
	on o.order_id = oi.order_id 
join project.payments_sql_project p
	on o.order_id = p.order_id 
left join project.products_sql_project pr
	on oi.product_id = pr.product_id 
left join project.users_sql_project u
	on o.user_id = u.user_id 
left join project.shipments_sql_project s
	on o.order_id = s.order_id),
offline_sales as (
select 'Offline'::text as sales_channel,
		so.store_order_id::text as order_id,
		so.order_date::date as order_date,
		so.user_id::text as user_id,
		soi.store_item_id::text as item_id,
		soi.product_id::text as product_id,
		soi.quantity as quantity,
		sp.store_payment_id::text as payment_id,
		sp.payment_method::text as payment_method,
		sp.payment_status::text as payment_status,
		spr.product_name::text as product_name,
		spr.product_category::text as product_category,
		spr.product_price as product_price,
		spr.product_brand::text as product_brand,
		spr.model_code::text as model_code,
		spr.weight_kg as weight_kg,
		spr.color::text as color,
		spr.warranty_months as warranty_months,
		su.user_name::text as user_name,
		su.user_email::text as user_email,
		su.user_city::text as user_city,
		su.user_phone::text as user_phone,
		su.user_age as user_age,
		su.user_gender::text as user_gender,
		su.user_address::text as user_address,
		su.loyalty_status::text as loyalty_status,
		su.account_created::date as account_created,
		null::text as shipment_id,
		null::text as courier,
		null::text as tracking_number,
		null::date as shipment_date,
		null::date as delivery_date,
		null::text as delivery_status
from project.store_orders so
join project.store_order_items soi 
	on so.store_order_id = soi.store_order_id 
join project.store_payments sp
	on so.store_order_id = sp.store_order_id 
left join project.products_sql_project spr
	on soi.product_id = spr.product_id 
left join project.users_sql_project su
	on so.user_id = su.user_id 
)
select * 
from online_sales
union all 
select * 
from offline_sales;