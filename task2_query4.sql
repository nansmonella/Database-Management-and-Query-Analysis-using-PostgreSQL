--List top rated 5 sellers in Sao Paulo for auto (automotivo) products. 
--The sellers must have at least 10 reviews. Show seller id, avg rating and review count, with descending order for avg rating 

select 
	oi.seller_id, COUNT(*) AS review_count,
    AVG(or2.review_score) AS avg_rating
from 
	sellers s
join 
	order_items oi on s.seller_id = oi.seller_id 
join 
	orders o on o.order_id = oi.order_id 
join 
	order_reviews or2 on or2.order_id = oi.order_id 
join 
	products p on p.product_id = oi.product_id 
where 
	s.seller_city = 'sao paulo' 
and 
	p.product_category_name = 'automotivo' 
group by 
	oi.seller_id 
having 
	count(*)>=10
order by 
	avg_rating desc
limit 5;
