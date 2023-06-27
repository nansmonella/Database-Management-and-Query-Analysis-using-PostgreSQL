select 
	oi.product_id, 
	COUNT(or2.review_score) AS review_count,
    AVG(or2.review_score) AS review_avg
    
from 
	products p 
join 
	order_items oi on oi.product_id = p.product_id 
join 
	orders o on oi.order_id = o.order_id 
join 
	order_reviews or2 on or2.order_id = o.order_id 
where 
	p.product_category_name = 'eletronicos' 
group by 
	oi.product_id 
having 
	count(*)>=5	 
order by 
	review_avg DESC, 
    review_count DESC 
LIMIT 10;