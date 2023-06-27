create table if not exists product_category (
	product_category_name VARCHAR(75),
	product_category_name_english VARCHAR(75)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(32),
    customer_unique_id VARCHAR(32),
    customer_zip_code_prefix VARCHAR(5),
    customer_city VARCHAR(50),
    customer_state VARCHAR(5),
    PRIMARY KEY (customer_id)
);


CREATE TABLE IF NOT EXISTS geolocation (
    geolocation_zip_code_prefix VARCHAR(5),
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city VARCHAR(50),
    geolocation_state VARCHAR(5)
);

CREATE TABLE IF NOT EXISTS order_payments (
    order_id VARCHAR(32),
    payment_sequential INT,
    payment_type VARCHAR(32),
    payment_installments INT,
    payment_value NUMERIC,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,
    UNIQUE (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(32),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create TABLE IF NOT EXISTS sellers (
    seller_id VARCHAR(32),
    seller_zip_code_prefix VARCHAR(5),
    seller_city VARCHAR(50),
    seller_state VARCHAR(5),
    PRIMARY KEY (seller_id)
);

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(32),
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    products_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS order_reviews (
    review_id VARCHAR(32),
    order_id VARCHAR(32),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
