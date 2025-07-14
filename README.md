# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Sales Analysis project
**Level**: Beginner  
**Database**: `project1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `project1`.
- **Table Creation**: A table named `retailsales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE project1;
USE project1;

CREATE TABLE retailsales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantity FLOAT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT 
    *
FROM
    retailsales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;


SET SQL_SAFE_UPDATES = 0;
DELETE FROM retailsales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
SELECT 
    *
FROM
    retailsales;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT 
    *
FROM
    RETAILSALES
WHERE
    SALE_DATE = '2022-11-05'; 
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
    *
FROM
    RETAILSALES
WHERE
    CATEGORY = 'CLOTHING' AND QUANTITY >= 4
        AND YEAR(SALE_DATE) = 2022
        AND MONTH(SALE_DATE) = 11
;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category, SUM(total_sale) AS net_sales
FROM
    retailsales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
    AVG(age) AS Average_age
FROM
    retailsales
WHERE
    category = 'beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT 
    transactions_id
FROM
    retailsales
WHERE
    total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    gender, category, COUNT(transactions_id) AS total_trans
FROM
    retailsales
GROUP BY 1 , 2; 
```

7. **Write a SQL query to calculate the average sale for each month **:
```sql
SELECT 
year(sale_date) AS Year,
month(sale_date) AS Month ,
AVG(total_sale) AS avg_sale,
RANK() OVER (partition by year(sale_date) order by avg(total_sale) DESC) 
FROM retailsales
GROUP BY 1,2;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id, SUM(total_sale)
FROM
    retailsales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    COUNT(DISTINCT customer_id), category
FROM
    retailsales
GROUP BY 2;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS(
SELECT *,
    CASE
        WHEN HOUR(sale_time)<12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
        ELSE "Evening"
    END AS shift
    FROM retailsales)

SELECT 
shift,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY 1;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Junaid Hasan



