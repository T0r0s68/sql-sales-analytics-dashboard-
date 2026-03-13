CREATE DATABASE sales_analytics;

USE sales_analytics;

--------------------------------------------------
-- SUPPLIERS
--------------------------------------------------

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    country VARCHAR(50)
);

--------------------------------------------------
-- REGIONS
--------------------------------------------------

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100)
);

--------------------------------------------------
-- RETAILERS
--------------------------------------------------

CREATE TABLE retailers (
    retailer_id INT PRIMARY KEY,
    retailer_name VARCHAR(100),
    country VARCHAR(50),
    region_id INT,

    CONSTRAINT fk_retailers_region
    FOREIGN KEY (region_id)
    REFERENCES regions(region_id)
);

--------------------------------------------------
-- PRODUCTS
--------------------------------------------------

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    supplier_id INT,

    CONSTRAINT fk_products_supplier
    FOREIGN KEY (supplier_id)
    REFERENCES suppliers(supplier_id)
);

--------------------------------------------------
-- ORDERS
--------------------------------------------------

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    retailer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,

    CONSTRAINT fk_orders_retailer
    FOREIGN KEY (retailer_id)
    REFERENCES retailers(retailer_id),

    CONSTRAINT fk_orders_product
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);