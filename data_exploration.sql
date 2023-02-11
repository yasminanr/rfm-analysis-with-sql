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

-- Check which productline has the most and least total sales.
SELECT
	productline,
	SUM(sales) AS total_sales
FROM sales
GROUP BY productline
ORDER BY total_sales DESC;
-- The productline with the most sales is Classic Cars, and the least is Trains.

-- Check which year has the most and least total sales.
SELECT
	year_id,
	SUM(sales) AS total_sales
FROM sales
GROUP BY year_id
ORDER BY total_sales DESC;
-- The year with the most sales is 2004, and the least is 2005. This is a bit concerning, because the amount of sales in
-- 2005 is less than half of how much it was in 2004.
-- So we will check the unique month_id for each year, to check if the year 2005 has data from the same number of months as 2003 and 2004.

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
-- The year 2005 only has data for 5 months. This might explain why the total sales is so much lower than the years before.

SELECT
	dealsize,
	SUM(sales) AS total_sales
FROM sales
GROUP BY dealsize
ORDER BY total_sales DESC;
-- The medium dealsize has the most total sales compared to small and large.

-- What was the best month for sales in a specific year? 
SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2003
GROUP BY month_id
ORDER BY total_sales DESC;
-- In 2003, the month with the highest sales is November.

SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2004
GROUP BY month_id
ORDER BY total_sales DESC;
-- In 2004, the month with the highest sales is also November.

SELECT
	month_id,
    SUM(sales) AS total_sales,
    COUNT(*) AS num_of_orders
FROM sales
WHERE year_id = 2005
GROUP BY month_id
ORDER BY total_sales DESC;
-- In 2005, the month with the highest sales is May.

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
-- In those months, the product which contributes the most to the total sales is Classic Cars.

