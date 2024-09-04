CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
) DISTRIBUTED BY (customer_id);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
) DISTRIBUTED BY (product_id);


CREATE TABLE sales_transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * price) STORED,
    created_at TIMESTAMP DEFAULT NOW()
) DISTRIBUTED BY (transaction_id);


CREATE TABLE shipping_details (
    transaction_id INT REFERENCES sales_transactions(transaction_id),
    shipping_date DATE NOT NULL,
    shipping_address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (transaction_id)
) DISTRIBUTED BY (transaction_id);
