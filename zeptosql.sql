USE zepto;
DROP TABLE zepto;

CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);


USE zepto;
ALTER TABLE zepto MODIFY COLUMN outOfStock VARCHAR(10);

SELECT COUNT(*)  FROM zepto;

SELECT * FROM zepto LIMIT 10;

SELECT
SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category_nulls,
SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
SUM(CASE WHEN mrp IS NULL THEN 1 ELSE 0 END) AS mrp_nulls,
SUM(CASE WHEN discountPercent IS NULL THEN 1 ELSE 0 END) AS discount_nulls,
SUM(CASE WHEN availableQuantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
SUM(CASE WHEN discountedSellingPrice IS NULL THEN 1 ELSE 0 END) AS selling_price_nulls,
SUM(CASE WHEN weightInGms IS NULL THEN 1 ELSE 0 END) AS weight_nulls,
SUM(CASE WHEN outOfStock IS NULL THEN 1 ELSE 0 END) AS stock_nulls
FROM zepto;

SELECT DISTINCT category
FROM zepto
ORDER BY category;

SELECT category, COUNT(*) AS total_products FROM zepto GROUP BY category ORDER BY total_products DESC;

SELECT outOfStock, COUNT(*) AS product_count FROM zepto GROUP BY outOfStock;

SELECT name, COUNT(*) AS sku_count FROM zepto GROUP BY name HAVING COUNT(*) > 1 ORDER BY sku_count DESC;

SELECT * FROM zepto WHERE mrp = 0 OR discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM zepto WHERE mrp = 0 OR discountedSellingPrice = 0;
SET SQL_SAFE_UPDATES = 1;

SELECT name, mrp/100.0 AS mrp_rupees,
discountedSellingPrice/100.0 AS selling_price_rupees FROM zepto;

CREATE VIEW zepto_clean AS
SELECT
sku_id,
category,
name,
mrp/100 AS mrp_rupees,
discountPercent,
availableQuantity,
discountedSellingPrice/100 AS selling_price_rupees,
weightInGms,
outOfStock,
quantity
FROM zepto;

SELECT
name,
category,
discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

SELECT
name,
category,
mrp
FROM zepto
WHERE outOfStock = 'TRUE'
ORDER BY mrp DESC;

SELECT
category,
SUM(discountedSellingPrice * availableQuantity) AS potential_revenue
FROM zepto
GROUP BY category
ORDER BY potential_revenue DESC;

SELECT
name,
category,
mrp,
discountPercent
FROM zepto
WHERE mrp > 500
AND discountPercent < 10
ORDER BY mrp DESC;

SELECT
category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

SELECT
name,
category,
discountedSellingPrice,
weightInGms,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms > 0
ORDER BY price_per_gram;

SELECT
name,
category,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms > 0
ORDER BY price_per_gram ASC
LIMIT 10;

SELECT
name,
weightInGms,
CASE
    WHEN weightInGms < 500 THEN 'Low'
    WHEN weightInGms BETWEEN 500 AND 2000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;

SELECT
CASE
    WHEN weightInGms < 500 THEN 'Low'
    WHEN weightInGms BETWEEN 500 AND 2000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category,
COUNT(*) AS total_products
FROM zepto
GROUP BY weight_category;

SELECT
category,
SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;

WITH ranked_products AS (
    SELECT
        category,
        name,
        discountPercent,
        ROW_NUMBER() OVER(
            PARTITION BY category
            ORDER BY discountPercent DESC
        ) AS ranking
    FROM zepto
)
SELECT *
FROM ranked_products
WHERE ranking <= 3;

WITH ranked_products AS (
    SELECT
        category,
        name,
        mrp,
        ROW_NUMBER() OVER(
            PARTITION BY category
            ORDER BY mrp DESC
        ) AS rn
    FROM zepto
)
SELECT *
FROM ranked_products
WHERE rn = 1;

SELECT
category,
ROUND(
SUM(discountedSellingPrice * availableQuantity) * 100 /
SUM(SUM(discountedSellingPrice * availableQuantity)) OVER (),
2
) AS revenue_percentage
FROM zepto
GROUP BY category
ORDER BY revenue_percentage DESC;