CREATE TABLE user_review_scores (
    product_id VARCHAR(32),
    avg_review_score FLOAT,
    total_reviews INT,
    PRIMARY KEY (product_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE FUNCTION prevent_zip_00000() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.zip_code = '00000' THEN
    RAISE EXCEPTION 'Zip code of the seller CAN NOT be zero!';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_zip_00000
BEFORE INSERT ON sellers
FOR EACH ROW
EXECUTE FUNCTION prevent_zip_00000();


CREATE VIEW order_product_customer_review AS
SELECT
    o.order_id,
    oi.product_id,
    o.customer_id,
    orr.review_score
FROM
    orders o
JOIN 
	order_items oi ON o.order_id = oi.order_id
JOIN 
	order_reviews orr ON o.order_id = orr.order_id;