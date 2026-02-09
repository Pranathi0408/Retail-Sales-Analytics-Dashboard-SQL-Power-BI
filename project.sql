show databases;

# creating a new database
create database retail_analysis;

# before using activate database
use retail_analysis;

# Creating a table
CREATE TABLE retail_raw (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

# Asking to show tables
show tables;

# Loading Data into Table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/online_retail_II.csv'
INTO TABLE retail_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# Verify Row Count
SELECT COUNT(*) FROM retail_raw;

# changing the data type
SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'retail_enriched'
AND COLUMN_NAME = 'InvoiceDate';

# Data Cleaning
# Check Returns (Negative Quantity)
SELECT COUNT(*) 
FROM retail_raw
WHERE Quantity <= 0;

# Check Cancelled Invoices
SELECT COUNT(*) 
FROM retail_raw
WHERE InvoiceNo LIKE 'C%';

# Check Missing Customers
SELECT COUNT(*) 
FROM retail_raw
WHERE CustomerID IS NULL;

# Create Clean Analytical Table
CREATE TABLE retail_cleaned AS
SELECT *
FROM retail_raw
WHERE Quantity > 0
AND UnitPrice > 0
AND InvoiceNo NOT LIKE 'C%';

# Check Clean Row Count
SELECT COUNT(*) FROM retail_cleaned;

# Add Revenue Column
CREATE TABLE retail_enriched AS
SELECT *, Quantity * UnitPrice AS revenue
FROM retail_cleaned;

SELECT COUNT(*) FROM retail_enriched;

# KPI Queries
# Total Revenue
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_enriched;

# Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM retail_enriched;

# Total Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM retail_enriched;

# Average Order Value
SELECT ROUND(SUM(revenue) / COUNT(DISTINCT InvoiceNo), 2) AS avg_order_value
FROM retail_enriched;

# Monthly Revenue Trend
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    ROUND(SUM(revenue),2) AS monthly_revenue
FROM retail_enriched
GROUP BY month
ORDER BY month;

# InvoiceDate converting to DATE/DATETIME
SELECT InvoiceDate
FROM retail_enriched
LIMIT 5;

# Monthly Revenue Trend
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS monthly_revenue
FROM retail_enriched
GROUP BY month
ORDER BY month;

# Top 10 Customers
SELECT 
    CustomerID,
    ROUND(SUM(revenue), 2) AS total_spent
FROM retail_enriched
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

# Top 5 Products
# Country-wise Revenue
SELECT 
    Country,
    ROUND(SUM(revenue), 2) AS country_revenue
FROM retail_enriched
GROUP BY Country
ORDER BY country_revenue DESC;

# Create Final Aggregation Views
# Monthly Revenue Table
CREATE VIEW monthly_revenue AS
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS monthly_revenue
FROM retail_enriched
GROUP BY month
ORDER BY month;

# Country Revenue Table
CREATE VIEW country_revenue AS
SELECT 
    Country,
    ROUND(SUM(revenue), 2) AS country_revenue
FROM retail_enriched
GROUP BY Country
ORDER BY country_revenue DESC;

# Top Customers Table
CREATE VIEW top_customers AS
SELECT 
    CustomerID,
    ROUND(SUM(revenue), 2) AS total_spent
FROM retail_enriched
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 20;

# Calculate Repeat Purchase Rate:
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN order_count > 1 THEN CustomerID END) /
        COUNT(DISTINCT CustomerID) * 100,
    2) AS repeat_customer_rate
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS order_count
    FROM retail_enriched
    GROUP BY CustomerID
) t;

# KPI
SELECT 
    ROUND(SUM(revenue),2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    ROUND(SUM(revenue)/COUNT(DISTINCT InvoiceNo),2) AS avg_order_value
FROM retail_enriched;

