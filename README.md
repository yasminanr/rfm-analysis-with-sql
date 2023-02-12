# RFM Analysis in SQL
Here we will perform customer segmentation analysis using RFM (Recency, Frequency, and Monetary value) using sales data from a company who sells vehicles.
<br>
You can get the data [here](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data).
 
Data exploration findings:
- The company sells vehicles in 7 categories (PRODUCTLINES): Motorcycles, Classic cars, Trucks and buses, Vintage cars, Planes, Ships, and Trains.
- The productline with the most sales is Classic Cars, and the least is Trains.
- The company sells to customers from 19 different countries, grouped into 4 territories; NA (North America), EMEA (Europe, the Middle East, and Africa), APAC (Asia-Pacific), and Japan.
- We have sales data from the year 2003 - 2005.
- The year with the most sales is 2004, and the least is 2005. This is a bit concerning, because the amount of sales in 2005 is less than half of how much it was in 2004. But after checking the number of months within each year, it turns out that the year 2005 only has data for 5 months. This might explain why the total sales is so much lower than the years before.
- In 2003 and 2004, the month with the highest sales is November. In 2005, the month with the highest sales is May. In those months, the product which contributes the most to the total sales is Classic Cars.
- The company groups their transactions into small, medium, and large dealsizes. The medium dealsize has the highest total sales.
- We have 92 unique customers. Looking at the customer names (e.g. Land of Toys Inc., Daedalus Designs Imports, Australian Collectors, Co., etc.), it seems that all the buyers are companies or corporations.
- There are 6 different statuses: Shipped, Disputed, In Process, Cancelled, On Hold, and Resolved.
