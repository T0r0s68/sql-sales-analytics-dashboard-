USE sales_analytics;

-- Suppliers
INSERT INTO suppliers VALUES
(1,'Intel Components Supply','USA'),
(2,'AMD Semiconductor Partners','USA'),
(3,'Nvidia Chip Distribution','USA'),
(4,'Samsung Electronics Supply','South Korea'),
(5,'SK Hynix Semiconductor','South Korea'),
(6,'Micron Memory Supply','USA'),
(7,'ASUS Hardware Distribution','Taiwan'),
(8,'Gigabyte Component Supply','Taiwan'),
(9,'MSI Manufacturing Partners','Taiwan'),
(10,'Western Digital Storage Supply','USA'),
(11,'Seagate Storage Distribution','USA'),
(12,'Corsair Hardware Supply','USA');


-- Regions
INSERT INTO regions VALUES
(1,'North America'),
(2,'Europe'),
(3,'Asia Pacific'),
(4,'South America');


-- Retailers
INSERT INTO retailers VALUES
(1,'Walmart','USA',1),
(2,'Amazon','USA',1),
(3,'Carrefour','France',2),
(4,'MediaMarkt','Germany',2),
(5,'Alibaba Retail','China',3),
(6,'Rakuten','Japan',3),
(7,'Mercado Libre','Brazil',4),
(8,'Best Buy','USA',1),
(9,'Target','USA',1),
(10,'JD Retail','China',3);


-- Products generation (200 products)

INSERT INTO products (product_id, product_name, category, price, supplier_id)

WITH RECURSIVE numbers AS (
SELECT 1 AS n
UNION ALL
SELECT n+1 FROM numbers WHERE n < 200
)

SELECT
n,

CASE 
WHEN n <= 20 THEN CONCAT('CPU Model ',n)
WHEN n <= 40 THEN CONCAT('GPU Model ',n)
WHEN n <= 60 THEN CONCAT('Motherboard Model ',n)
WHEN n <= 80 THEN CONCAT('RAM Kit ',n)
WHEN n <= 100 THEN CONCAT('SSD Drive ',n)
WHEN n <= 120 THEN CONCAT('HDD Drive ',n)
WHEN n <= 140 THEN CONCAT('Power Supply ',n)
WHEN n <= 160 THEN CONCAT('PC Case ',n)
WHEN n <= 170 THEN CONCAT('CPU Cooler ',n)
WHEN n <= 185 THEN CONCAT('Gaming Monitor ',n)
WHEN n <= 195 THEN CONCAT('Keyboard Mouse Combo ',n)
ELSE CONCAT('Network Adapter ',n)
END,

CASE 
WHEN n <= 20 THEN 'CPU'
WHEN n <= 40 THEN 'GPU'
WHEN n <= 60 THEN 'Motherboard'
WHEN n <= 80 THEN 'RAM'
WHEN n <= 100 THEN 'SSD'
WHEN n <= 120 THEN 'HDD'
WHEN n <= 140 THEN 'PSU'
WHEN n <= 160 THEN 'Case'
WHEN n <= 170 THEN 'Cooling'
WHEN n <= 185 THEN 'Monitor'
WHEN n <= 195 THEN 'Peripherals'
ELSE 'Networking'
END,

FLOOR(RAND()*900)+100,
FLOOR(RAND()*12)+1

FROM numbers;


-- Orders generation (~15000)

SET SESSION cte_max_recursion_depth = 20000;

INSERT INTO orders (order_id, retailer_id, product_id, order_date, quantity)

WITH RECURSIVE numbers AS (
SELECT 1 AS n
UNION ALL
SELECT n+1 FROM numbers WHERE n < 14392
)

SELECT
n,
FLOOR(RAND()*10)+1,
FLOOR(RAND()*200)+1,
DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*730) DAY),
FLOOR(RAND()*700)+100

FROM numbers;