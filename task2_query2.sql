SELECT 
    io.seller_id, 
    AVG(EXTRACT(EPOCH FROM (o.order_delivered_carrier_date - o.order_purchase_timestamp)) / 86400) AS the_duration
FROM 
    sellers s
join 
	order_items io on s.seller_id = io.seller_id 
join 
	products p on p.product_id = io.product_id 
join 
	orders o on o.order_id = io.order_id 
WHERE 
    s.seller_city = 'curitiba'
AND 
	p.product_category_name = 'beleza_saude'
GROUP BY 
    io.seller_id
HAVING 
    AVG(EXTRACT(EPOCH FROM (o.order_delivered_carrier_date - o.order_purchase_timestamp)) / 86400) <= 2
ORDER BY 
    the_duration DESC
LIMIT 5;