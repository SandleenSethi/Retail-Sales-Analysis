use retailschema;

SELECT COUNT(*) AS Total_Transactions FROM retail_sales_dataset;

-- View distinct product categories
SELECT DISTINCT Product_Category FROM retail_sales_dataset;

-- Sales summary by category
SELECT Product_Category, 
       SUM(Quantity) AS Total_Units_Sold, 
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Product_Category;

-- Monthly sales trend
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Month
ORDER BY Month;

-- Gender-wise revenue contribution
SELECT Gender,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Gender;

-- Age group-wise analysis (example with basic age buckets)
SELECT CASE 
          WHEN Age < 20 THEN 'Under 20'
          WHEN Age BETWEEN 20 AND 29 THEN '20-29'
          WHEN Age BETWEEN 30 AND 39 THEN '30-39'
          WHEN Age BETWEEN 40 AND 49 THEN '40-49'
          ELSE '50+' 
       END AS Age_Group,
       COUNT(*) AS Total_Transactions,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Age_Group
ORDER BY Age_Group;

-- Top 10 customers by total spend
SELECT Customer_ID,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue,
       COUNT(Transaction_ID) AS Transactions
FROM retail_sales_dataset
GROUP BY Customer_ID
ORDER BY Total_Revenue DESC
LIMIT 10;

-- ✅ Step 5: Create Views for Power BI or Reuse

-- View: Sales Summary by Product Category
CREATE OR REPLACE VIEW sales_summary_by_category AS
SELECT Product_Category, 
       SUM(Quantity) AS Total_Units_Sold, 
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Product_Category;

-- View: Monthly Sales Trend
CREATE OR REPLACE VIEW monthly_sales_trend AS
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Month;

-- View: Gender-wise Revenue
CREATE OR REPLACE VIEW gender_revenue_summary AS
SELECT Gender,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue
FROM retail_sales_dataset
GROUP BY Gender;

-- View: Customer Leaderboard
CREATE OR REPLACE VIEW top_customers AS
SELECT Customer_ID,
       SUM(Quantity * Price_Per_Unit) AS Total_Revenue,
       COUNT(Transaction_ID) AS Total_Transactions
FROM retail_sales_dataset
GROUP BY Customer_ID
ORDER BY Total_Revenue DESC
LIMIT 10;

-- ✅ Step 6: Check the Views
SELECT * FROM sales_summary_by_category;
SELECT * FROM monthly_sales_trend;
SELECT * FROM gender_revenue_summary;
SELECT * FROM top_customers;
