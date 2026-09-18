SELECT *
FROM superstore_sales;

/*ALTER TABLE superstore_sales
ADD datemonth VARCHAR(7);*/

/*UPDATE superstore_sales
SET datemonth = FORMAT(Order_Date,'yyyy-MM');*/

SELECT COUNT(Row_ID) as total_order_count
FROM superstore_sales;

SELECT 
MIN(Order_Date) as first_order,
MAX(Order_Date) as last_order
FROM superstore_sales;

SELECT COUNT (DISTINCT Ship_Mode) as shipmode_count
FROM superstore_sales;

SELECT COUNT (DISTINCT Customer_ID) as total_customer
FROM superstore_sales;

SELECT COUNT (DISTINCT Segment) as segment_count
FROM superstore_sales;

SELECT COUNT (DISTINCT Country) as country_count
FROM superstore_sales;

SELECT COUNT (DISTINCT City) as city_count
FROM superstore_sales;

SELECT COUNT (DISTINCT State) as state_count
FROM superstore_sales;

SELECT COUNT (DISTINCT Region) as region_count
FROM superstore_sales;

SELECT COUNT (DISTINCT Product_ID) as product_count
FROM superstore_sales;

/*UPDATE superstore_sales
SET original_price = (Sales/Quantity)/(1-Discount);*/

WITH RankedPrice AS (
	SELECT
		Product_ID,
		AVG(original_price) as Product_Price,
		ROW_NUMBER() OVER (ORDER BY AVG(original_price) DESC) AS Price_Rank
	FROM superstore_sales
	GROUP BY Product_ID
)
SELECT /*COUNT(*) as Total_Count*/
Product_ID,
Product_Price,
Price_Rank
FROM RankedPrice
WHERE Price_Rank IN (465, 931, 1396)
ORDER BY Price_Rank ASC;

/*ALTER TABLE superstore_sales
ADD price_category VARCHAR(20);*/

UPDATE superstore_sales
SET price_category = CASE
	WHEN original_price >=80.16 THEN 'High Cost'
	WHEN original_price BETWEEN 19.98 AND 80.15 THEN 'Medium Cost'
	ELSE 'Low Cost'
END

SELECT price_category,
COUNT (price_category) as pricecategory_count
FROM superstore_sales
GROUP BY price_category;

SELECT order_year,
COUNT(DISTINCT Customer_ID) as customer_count,
COUNT(Order_ID) as order_per_year
FROM superstore_sales
GROUP BY order_year
ORDER BY order_year;

SELECT DISTINCT Product_ID,
AVG(original_price) as price
FROM superstore_sales
GROUP BY Product_ID
ORDER BY price DESC;

SELECT COUNT (DISTINCT Category) as category_count
FROM superstore_sales;

SELECT COUNT (DISTINCT Sub_Category) as subcategory_count
FROM superstore_sales;

SELECT SUM (Sales) as total_sales
FROM superstore_sales;

SELECT datemonth ,
SUM (Sales) as Total_Sales,
SUM (Profit) as Total_Profit
FROM superstore_sales
GROUP BY datemonth
ORDER BY datemonth ASC;

SELECT SUM (Quantity) as total_sold
FROM superstore_sales;

SELECT COUNT (DISTINCT Discount) as disount_count
FROM superstore_sales;

SELECT SUM (Profit) as total_profit
FROM superstore_sales;

SELECT Product_ID,
MIN(order_year) as first_year,
MIN(Order_Date) as first_order,
MAX(Order_Date) as last_order,
DATEDIFF(year, MIN(Order_Date), MAX(Order_Date)) as year_dif,
DATEDIFF(year, MIN(Order_Date), '2017-12-30') as year_difference,
SUM(Quantity) as quantity_sold
FROM superstore_sales
GROUP BY Product_ID
ORDER BY first_year, year_difference;

SELECT order_year,
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
COUNT(Profit) as no_profit
FROM superstore_sales
WHERE Profit = 0
GROUP BY order_year;

SELECT order_year,
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
COUNT(Profit) as negative_profit
FROM superstore_sales
WHERE Profit < 0
GROUP BY order_year;

SELECT order_year,
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
COUNT(Profit) as with_profit
FROM superstore_sales
WHERE Profit > 0
GROUP BY order_year;

SELECT DISTINCT TOP 10 Product_Name,
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
COUNT(*) as number_order,
AVG(original_price) as origprice,
SUM(Quantity) as total_order_qty,
AVG(Discount) as avg_discount,
AVG (Profit) as avg_profit
FROM superstore_sales
WHERE Profit < 0 AND order_year = '2017'
GROUP BY Product_Name
ORDER BY avg_profit DESC;

SELECT DISTINCT TOP 10 Product_Name,
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
COUNT(*) as number_order,
AVG(original_price) as origprice,
SUM(Quantity) as total_order_qty,
AVG(Discount) as avg_discount,
AVG (Profit) as avg_profit
FROM superstore_sales
WHERE Profit = 0 AND order_year = '2015'
GROUP BY Product_Name
ORDER BY avg_profit DESC;

SELECT
/*COUNT (DISTINCT Product_ID) AS unique_product,*/
DISTINCT TOP 3 Product_Name,
AVG(Profit) as avg_profit,
COUNT(Order_ID) as order_no
FROM superstore_sales
WHERE price_category = 'Low Value'
GROUP BY Product_Name
HAVING AVG(Profit) <= 0
ORDER BY avg_profit

SELECT
COUNT (DISTINCT Product_ID) as product_count
FROM superstore_sales;

WITH CustomerFirstOrder AS (
SELECT
	Customer_ID,
	MIN(order_year) as order_year
FROM superstore_sales
GROUP BY Customer_ID
)
SELECT order_year,
COUNT(Customer_ID) AS new_customer
FROM CustomerFirstOrder
GROUP BY order_year
ORDER BY order_year;

SELECT
COUNT(DISTINCT Customer_ID) AS new_customer
FROM superstore_sales;

SELECT 
	Category,
	price_category,
	COUNT (DISTINCT Product_ID) AS unique_product
FROM superstore_sales
GROUP BY Category, price_category;

SELECT COUNT (DISTINCT Product_ID) AS High_Value_count
FROM superstore_sales
WHERE price_category = 'High Value';

SELECT COUNT (DISTINCT Product_ID) AS Mid_Value_count
FROM superstore_sales
WHERE price_category = 'Mid Value';

SELECT COUNT (DISTINCT Product_ID) AS Low_Value_count
FROM superstore_sales
WHERE price_category = 'Low Value';

SELECT MAX(original_price) as highest_price,
MIN(original_price) as lowest_price
FROM superstore_sales;

SELECT COUNT(DISTINCT original_price) as original_price_count
FROM superstore_sales;

SELECT AVG(DISTINCT original_price) as original_price_avg
FROM superstore_sales;

SELECT order_year,
Order_Date,
Product_ID,
Sales,
Quantity,
Discount,
Profit
FROM superstore_sales
WHERE Product_ID = 'FUR-TA-10000577'
ORDER BY Order_Date;

/*ALTER TABLE superstore_sales
ALTER COLUMN Sales DECIMAL(10,2);
ALTER TABLE superstore_sales
ALTER COLUMN Profit DECIMAL(10,2);
ALTER TABLE superstore_sales
ALTER COLUMN Discount DECIMAL(10,2);*/
/*UPDATE superstore_sales
SET Discount = Discount/100.0;*/
/*ALTER TABLE superstore_sales
ADD original_price DECIMAL(10,2);*/

SELECT 
	order_year, 
	SUM(CASE WHEN Ship_Mode = 'First Class' THEN 1 ELSE 0 END) AS first_class,
	SUM(CASE WHEN Ship_Mode = 'Same Day' THEN 1 ELSE 0 END) AS same_day,
	SUM(CASE WHEN Ship_Mode = 'Standard Class' THEN 1 ELSE 0 END) AS standard_class,
	SUM(CASE WHEN Ship_Mode = 'Second Class' THEN 1 ELSE 0 END) AS second_class
FROM superstore_sales
GROUP BY order_year
ORDER BY order_year;

SELECT Product_Name,
SUM(Sales) AS Total_Sales,
SUM(Profit) as Total_Profit
FROM superstore_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC;