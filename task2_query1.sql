--List city of customers who buy products only with voucher.

select distinct 
	c.customer_city
from 
	customers c
join 
	orders o on c.customer_id = o.customer_id 
join 
	order_payments op on o.order_id = op.order_id 
where 
	op.payment_type = 'voucher'
and not exists (
	select 
		* 
	from 
		order_payments 
	where 
		order_id = o.order_id 
	and 
		payment_type <> 'voucher'
	)
group by 
	c.customer_id 
