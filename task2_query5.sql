WITH monthly_order_totals AS (
    SELECT 
        EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
        o.customer_id,
        SUM(oi.price + oi.freight_value) AS total
    FROM 
    	order_items oi
    JOIN 
    	orders o ON oi.order_id = o.order_id
    GROUP BY 
    	o.customer_id, year, month
)
SELECT 
    customer_id,
    year,
    month,
    max_order_for_month 
FROM (
    SELECT 
        year,
        month,
        customer_id,
        total AS max_order_for_month,
        RANK() OVER 
        	(PARTITION BY year, month ORDER BY total DESC) as rank
    FROM 
    monthly_order_totals
) hello
WHERE 
	hello.rank = 1
ORDER BY 
	year ASC, 
	month ASC
LIMIT 25;