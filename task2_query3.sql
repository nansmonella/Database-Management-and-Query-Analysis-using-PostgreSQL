select 
	p.product_category_name, 
	COUNT(*) AS late
from 
	products p 
join 
	order_items oi on oi.product_id = p.product_id 
join 
	orders o on o.order_id = oi.order_id 
join 
	customers c on c.customer_id = o.customer_id 
where 
	c.customer_city = 'rio de janeiro' 
and 
	o.order_estimated_delivery_date < o.order_delivered_customer_date 
and 
	o.order_purchase_timestamp between '2018-06-01' and '2018-09-01'
group by 
    p.product_category_name
ORDER BY 
    late DESC, 
    p.product_category_name ASC
LIMIT 23;
