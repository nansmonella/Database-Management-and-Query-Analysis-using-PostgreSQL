--Window functions:
--List the product ids, total sales (from order items table), product category names and product’s rank when ranked by total sales for each grouping formed by product category names. 
--Restrict your attention to those products with a total number of sales more than 10, inclusive.

with without_null as (
	select 
		*
	from 
		products p2
	where 
		p2.product_category_name != ''
	order by 
		p2.product_category_name 
), 
product_sales AS (
	SELECT 
  		oi.product_id, 
    	p.product_category_name,
    	COUNT(*) AS total_sales,
    	RANK() OVER (
    		PARTITION BY p.product_category_name 
    		ORDER BY COUNT(*) DESC) AS product_rank
  	FROM 
    	order_items oi
    JOIN 
    	without_null p ON oi.product_id = p.product_id
	GROUP BY 
    	oi.product_id, p.product_category_name
	HAVING 
    	COUNT(*) >= 10 
)
SELECT 
	product_sales.product_id, 
	product_sales.total_sales, 
	product_sales.product_rank,
 	product_sales.product_category_name
FROM 
  product_sales
where 
	product_sales.product_category_name is not null
order by 
	product_sales.product_category_name;
   
