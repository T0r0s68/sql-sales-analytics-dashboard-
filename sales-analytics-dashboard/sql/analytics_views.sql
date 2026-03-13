USE sales_analytics;

--------------------------------------------------
-- 1. Revenue View (base analytics layer)
--------------------------------------------------

CREATE VIEW revenue_view AS
SELECT
o.order_id,
o.order_date,
r.retailer_name,
rg.region_name,
p.product_name,
p.category,
s.supplier_name,
o.quantity,
p.price,
(p.price * o.quantity) AS revenue
FROM orders o
JOIN products p 
ON o.product_id = p.product_id
JOIN retailers r
ON o.retailer_id = r.retailer_id
JOIN regions rg
ON r.region_id = rg.region_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id;


--------------------------------------------------
-- 2. Category Revenue
--------------------------------------------------

CREATE VIEW category_revenue AS
SELECT
category,
SUM(revenue) AS total_revenue
FROM revenue_view
GROUP BY category
ORDER BY total_revenue DESC;


--------------------------------------------------
-- 3. Retailer Revenue
--------------------------------------------------

CREATE VIEW retailer_revenue AS
SELECT
retailer_name,
SUM(revenue) AS total_revenue
FROM revenue_view
GROUP BY retailer_name
ORDER BY total_revenue DESC;


--------------------------------------------------
-- 4. Supplier Revenue
--------------------------------------------------

CREATE VIEW supplier_revenue AS
SELECT
supplier_name,
SUM(revenue) AS total_revenue
FROM revenue_view
GROUP BY supplier_name
ORDER BY total_revenue DESC;


--------------------------------------------------
-- 5. Monthly Revenue
--------------------------------------------------

CREATE VIEW monthly_revenue AS
SELECT
DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(revenue) AS total_revenue
FROM revenue_view
GROUP BY month
ORDER BY month;


--------------------------------------------------
-- 6. Top Products
--------------------------------------------------

CREATE VIEW top_products AS
SELECT
product_name,
SUM(quantity) AS units_sold
FROM revenue_view
GROUP BY product_name
ORDER BY units_sold DESC;


--------------------------------------------------
-- 7. Region Revenue
--------------------------------------------------

CREATE VIEW region_revenue AS
SELECT
region_name,
SUM(revenue) AS total_revenue
FROM revenue_view
GROUP BY region_name
ORDER BY total_revenue DESC;


--------------------------------------------------
-- 8. Supplier Product Count
--------------------------------------------------

CREATE VIEW supplier_product_count AS
SELECT
s.supplier_name,
COUNT(p.product_id) AS products_count
FROM suppliers s
JOIN products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
ORDER BY products_count DESC;


--------------------------------------------------
-- 9. Average Order Value
--------------------------------------------------

CREATE VIEW average_order_value AS
SELECT
AVG(price * quantity) AS avg_order_value
FROM revenue_view;


--------------------------------------------------
-- 10. Orders per Retailer
--------------------------------------------------

CREATE VIEW orders_per_retailer AS
SELECT
retailer_name,
COUNT(order_id) AS total_orders
FROM revenue_view
GROUP BY retailer_name
ORDER BY total_orders DESC;