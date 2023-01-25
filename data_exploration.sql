-- SALES DATA EXPLORATION --

SET SQL_SAFE_UPDATES = 0;

-- Change the data type of the ORDERDATE column into date.
UPDATE sales
SET orderdate = STR_TO_DATE(orderdate, '%m/%d/%Y %H:%i')
WHERE orderdate IS NOT NULL;  

ALTER TABLE sales
MODIFY COLUMN orderdate DATE;

-- Checking the unique values in various columns

-- Check the unique values in STATUS column
SELECT
	DISTINCT status
FROM sales;
-- There are 6 different statuses: Shipped, Disputed, In Process, Cancelled, On Hold, Resolved.

-- Check the unique values in YEAR_ID column
SELECT
	DISTINCT year_id
FROM sales;
-- We have data from the year 2003 - 2005.

-- Check the unique values in PRODUCTLINE column
SELECT
	DISTINCT productline
FROM sales;
-- The company sells vehicles in 7 categories: Motorcycles, Classic cars, Trucks and buses, Vintage cars, Planes, Ships, and Trains.

-- Check the unique values in COUNTRY column
SELECT
	DISTINCT country
FROM sales;
-- The company sells vehicles to many customers in 19 different countries.

-- Check the unique values in DEALSIZE column
SELECT
	DISTINCT dealsize
FROM sales;
-- It seems that the company groups their transactions into small, medium, and large dealsizes.

-- Check the unique values in TERRITORY column
SELECT
	DISTINCT territory
FROM sales;
-- The company sells vehicles to customers in 4 territories: NA (North America), EMEA (Europe, the Middle East, and Africa), 
-- APAC (Asia-Pacific), and Japan

-- Check the unique values in CUSTOMERNAME column
SELECT
	DISTINCT customername
FROM sales;
-- We have 92 distinct customers. It seems that all the buyers are companies or corporations. 

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

