WITH seller_monthly_freight AS (
    SELECT
        seller_id,
        EXTRACT(YEAR FROM shipping_limit_date) AS year,
        EXTRACT(MONTH FROM shipping_limit_date) AS month,
        SUM(freight_value) AS monthly_freight_value
    FROM 
    	order_items
    WHERE 
    	EXTRACT(YEAR FROM shipping_limit_date) = 2018
    GROUP BY 
    	seller_id, year, month
),
syf AS (
    SELECT
        seller_id,
        year,
        SUM(monthly_freight_value) AS yearly_freight_value
    FROM 
    	seller_monthly_freight
    GROUP BY 
    	seller_id,
    	year
),
tas AS (
    SELECT
        year,
        SUM(yearly_freight_value) AS sum
    FROM 
    	syf
    GROUP BY 
    	year
)
SELECT
    seller_id,
    month,
    monthly_freight_value AS sum
FROM 
	seller_monthly_freight
UNION ALL
SELECT
    seller_id,
    NULL AS month,
    yearly_freight_value
FROM 
	syf
UNION ALL
SELECT
    NULL AS seller_id,
    NULL AS month,
    sum
FROM 
	tas 
ORDER BY 
	seller_id, 
	month;