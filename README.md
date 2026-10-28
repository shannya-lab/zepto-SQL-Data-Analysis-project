# zepto-SQL-Data-Analysis-project
SQL-based exploratory data analysis and business insights on Zepto product inventory data.

# 🛒 Zepto SQL Data Analysis

## Project Overview

This project focuses on analyzing Zepto's product inventory dataset using SQL. The objective was to perform data exploration, data cleaning, and business analysis to derive actionable insights from product pricing, inventory, categories, discounts, and stock availability.

---

## Tools Used

- MySQL
- SQL
- GitHub

---

## Dataset Information

The dataset contains product-level information including:

- Product Name
- Category
- MRP
- Discount Percentage
- Discounted Selling Price
- Available Quantity
- Stock Status
- Product Weight 

---

## Database Schema
``` sql
CREATE TABLE zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock VARCHAR(10),
quantity INTEGER
);   
```
---
**Data Exploration**

**Performed Analysis**

- Counted total records
- Explored sample dataset
- Checked null values
- Identified product categories
- Analyzed stock availability
- Found duplicate products with different SKUs

**Data Cleaning**

- Cleaning Steps
- Removed rows with zero MRP
- Removed rows with zero selling price
- Converted prices from paise to rupees
- Validated missing values

** Business Insights**

**Key Questions Answered**

✅ Top 10 products with highest discounts

✅ High-value products currently out of stock

✅ Potential revenue by category

✅ Expensive products with low discounts

✅ Categories offering highest average discounts

✅ Value-for-money products using price-per-gram metric

✅ Weight-based product segmentation

✅ Total inventory weight by category 

**Advanced SQL Concepts Used**

- Aggregate Functions
- CASE Statements
- GROUP BY
- HAVING
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Views

 
**Project Outcomes**

**The analysis helped identify:**

- Product categories with maximum revenue potential
- Categories providing the largest discounts
- Inventory-heavy categories
- Products delivering the best value to customers
- High-priced products facing stock shortages


