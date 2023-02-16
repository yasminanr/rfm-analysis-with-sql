-- RFM ANALYSIS --

-- Calculate RFM scores

DROP TEMPORARY TABLE IF EXISTS rfm;
CREATE TEMPORARY TABLE rfm AS
WITH rfm AS
(
	SELECT
		customername,
		SUM(sales) AS monetary_value,
		AVG(sales) AS avg_monetary_value,
		COUNT(ordernumber) AS frequency,
		MAX(orderdate) AS last_order_date,
		(SELECT
			MAX(orderdate) 
			FROM sales) AS max_order_date,
		TIMESTAMPDIFF(DAY, MAX(orderdate), (SELECT MAX(orderdate) FROM sales)) AS recency
	FROM sales
	GROUP BY customername
),
rfm_score AS 
(
	SELECT
		*,
		NTILE(4) OVER (ORDER BY recency DESC) AS rfm_recency,
		NTILE(4) OVER (ORDER BY frequency) AS rfm_frequency,
		NTILE(4) OVER (ORDER BY monetary_value) AS rfm_monetary
	FROM rfm
)
SELECT
	*,
    rfm_recency + rfm_frequency + rfm_monetary AS rfm_total_score,
    CONCAT(rfm_recency, rfm_frequency, rfm_monetary) AS rfm_score_concat
FROM rfm_score;

-- Segment customers using regular expression

DROP TEMPORARY TABLE IF EXISTS rfm_segments;
CREATE TEMPORARY TABLE rfm_segments AS
SELECT
	customername,
    rfm_recency,
    rfm_frequency,
    rfm_monetary,
    CASE 
		WHEN rfm_score_concat REGEXP '^1[1-4][1-3]$' THEN 'churned_customer'
        WHEN rfm_score_concat REGEXP '^[1-2][1-4]4$' THEN 'high_value_churned'
        WHEN rfm_score_concat REGEXP '^[3-4][1-2][1-2]$' THEN 'new_customer'
        WHEN rfm_score_concat REGEXP '^2[1-3][1-3]$' THEN 'potential_churners'
        WHEN rfm_score_concat REGEXP '^[3-4][3-4][3-4]$' THEN 'loyal_customer'
        WHEN rfm_score_concat REGEXP '^[3-4][2-4][2-4]$' THEN 'active_customer'
	END AS rfm_segment
FROM rfm;
	
-- Show customer segmentation result 

SELECT 
	rfm_segment,
    COUNT(customername) AS segment_count
FROM rfm_segments
GROUP BY rfm_segment
ORDER BY segment_count DESC;
