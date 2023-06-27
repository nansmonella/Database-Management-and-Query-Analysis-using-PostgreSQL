--Cross tabulations:
--Write a single SQL query that computes the statistics present in a cross tabulation over sellers and months (use shipping limit date) on order items table. 
--The aggregate reported should report total freight values for each seller-month pair in 2018. 
--In addition to seller-month pairs, the results should contain seller yearly total freight values, and also total freight value of all sellers and all months at the end.
--Each result row should contain seller id, month and total freight value.

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
