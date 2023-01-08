-- SALES DATA EXPLORATION --

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET orderdate = STR_TO_DATE(orderdate, '%m/%d/%Y %H:%i')
WHERE orderdate IS NOT NULL;  

ALTER TABLE sales
MODIFY COLUMN orderdate DATE;

SELECT
	DISTINCT status
FROM sales;

SELECT
	DISTINCT year_id
FROM sales;

SELECT
	DISTINCT productline
FROM sales;

SELECT
	DISTINCT country
FROM sales;

SELECT
	DISTINCT dealsize
FROM sales;

SELECT
	DISTINCT territory
FROM sales;

SELECT
	DISTINCT customername
FROM sales;

SELECT
	productline,
	SUM(sales) AS total_sales
FROM sales
GROUP BY productline
ORDER BY total_sales DESC;

SELECT
	year_id,
	SUM(sales) AS total_sales
FROM sales
GROUP BY year_id
ORDER BY total_sales DESC;

SELECT 
	DISTINCT month_id
FROM sales
WHERE year_id = 2005
ORDER BY month_id;

SELECT
	DISTINCT month_id
FROM sales
WHERE year_id = 2003
ORDER BY month_id;

SELECT
	DISTINCT month_id
FROM sales
WHERE year_id = 2004
ORDER BY month_id;

SELECT
	dealsize,
	SUM(sales) AS total_sales
FROM sales
GROUP BY dealsize
ORDER BY total_sales DESC;

-- What was the best month for sales in a specific year? How much was earned that month?
SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2003
GROUP BY month_id
ORDER BY total_sales DESC;

SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2004
GROUP BY month_id
ORDER BY total_sales DESC;

SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2005
GROUP BY month_id
ORDER BY total_sales DESC;

-- What products did they sell the most in that month?
SELECT
	month_id,
    productline,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2003 AND month_id = 11
GROUP BY month_id, productline
ORDER BY total_sales DESC;

SELECT
	month_id,
    productline,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2004 AND month_id = 11
GROUP BY month_id, productline
ORDER BY total_sales DESC;

SELECT
	month_id,
    productline,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2005 AND month_id = 5
GROUP BY month_id, productline
ORDER BY total_sales DESC;

