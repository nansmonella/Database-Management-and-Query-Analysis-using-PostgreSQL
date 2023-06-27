--Find best sellers of Q1 - 2018 (between January 1st - April 1st). 
--Best sellers are who sold at least 50 items in each month of Q1 2018. 
--Show seller id, total earned using order item prices in Q1, with descending order for total earned 
with januaryMonth as (
	select 
		oi.seller_id, 
		sum(oi.price) as theSumForJan
	from 
		order_items oi 
	join 
		orders o on o.order_id = oi.order_id 
	where 
		o.order_purchase_timestamp >= '2018-01-01' 
	AND 
		o.order_purchase_timestamp <= '2018-02-01'
	group by 
		oi.seller_id
	having 
		count(*)>50
	), 
februaryMonth as (
	select 
		oi.seller_id, 
		sum(oi.price) as theSumForFeb
	from 
		order_items oi 
	join 
		orders o on o.order_id = oi.order_id 
	where 
		o.order_purchase_timestamp >= '2018-02-01' 
	AND 
		o.order_purchase_timestamp <= '2018-03-01'
	group by 
		oi.seller_id
	having 
		count(*)>50
	), 
marchMonth as (
	select 
		oi.seller_id, 
		sum(oi.price) as theSumForMarch
	from 
		order_items oi 
	join 
		orders o on o.order_id = oi.order_id 
	where 
		o.order_purchase_timestamp >= '2018-03-01' 
	AND 
		o.order_purchase_timestamp <= '2018-04-01'
	group by 
		oi.seller_id
	having 
		count(*)>50
	) 
select 
	j.seller_id, 
	theSumForJan+theSumForFeb+theSumForMarch as total_earned
from 
	januaryMonth j
join 
	februaryMonth f on j.seller_id=f.seller_id
join 
	marchMonth m on f.seller_id=m.seller_id
order by 
	total_earned desc
