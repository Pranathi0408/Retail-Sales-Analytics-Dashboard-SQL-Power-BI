📊 # Retail-Sales-Analytics-Dashboard | SQL & Power BI
🔍 Project Overview

This project analyzes 1M+ retail transactions to uncover revenue trends, customer behavior, and geographic performance insights using MySQL and Power BI.
The goal was to build an end-to-end analytics pipeline — from raw transactional data ingestion to interactive business intelligence dashboard reporting.

📁 Dataset
Online Retail II dataset
1,067,743 transactional records
Time period: Dec 2009 – Dec 2011
Fields include: InvoiceNo, Quantity, UnitPrice, CustomerID, Country, InvoiceDate

⚙️ Data Processing (SQL)   
1️⃣ Data Ingestion  
Imported 1M+ rows using LOAD DATA INFILE  
Structured raw data into relational table  

2️⃣ Data Cleaning  
Removed cancelled invoices (InvoiceNo LIKE 'C%')  
Eliminated negative quantities (returns)  
Filtered invalid unit prices   
Created cleaned analytical table  

3️⃣ Feature Engineering  
Created revenue column:  
revenue = Quantity × UnitPrice  
Converted InvoiceDate to proper datetime format  
Built aggregation views for reporting

📈 Key Business KPIs
💰 Total Revenue: ₹20.98M
🧾 Total Orders: 40,077
👥 Unique Customers: 5,879
📦 Average Order Value: ₹523.60
🔁 Repeat Purchase Rate: 72.39%
📊 Dashboard Insights (Power BI)

The Power BI dashboard includes:
Monthly Revenue Trend
Country-wise Revenue Performance
Top 10 Customers by Revenue
KPI Cards for executive reporting

Key Observations

The UK contributes the majority of total revenue.  
Revenue shows strong seasonal spikes in Q4.  
Top 10 customers account for significant revenue concentration.  
High repeat purchase rate indicates strong customer retention.  

🛠️ Tools & Technologies  
MySQL (Data Cleaning & Aggregation)  
Power BI (Dashboard & Visualization)  
SQL (Views, Aggregations, KPI computation)  

🚀 How to Reproduce   
Import dataset into MySQL.  

Execute SQL scripts:
Create raw table  
Clean dataset   
Create revenue metric   
Generate aggregation views   
Export aggregation tables.  
Load into Power BI.   
Build dashboard visuals.   

📌 Project Structure
/sql   
   retail_schema.sql  
   data_cleaning.sql   
   kpi_queries.sql  

/powerbi   
   Online_Retail_Dashboard.pbix

