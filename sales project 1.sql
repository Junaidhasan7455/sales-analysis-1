#Retail_sales
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
    
SELECT 
    *
FROM
    retailsales;

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
        
##Deleting_Null
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

##DATA_EXPLORATION 

#HOW MANY UNIQUE CUSTOMER WE HAVE
SELECT COUNT(DISTINCT CUSTOMER_ID) FROM RETAILSALES AS TOTAL_CUSTOMER;

#HOW MANY UNIQUE CATEGORY  WE HAVE
SELECT DISTINCT category FROM RETAILSALES AS TOTAL_CATEGORY;

 

##DATA ANALYSIS

 # 1.WRITE A SQL QUERY TO RETRIEVE ALL THE COULMNS FOR SALES MADE ON 2022-11-05  
SELECT 
    *
FROM
    RETAILSALES
WHERE
    SALE_DATE = '2022-11-05'; 

# 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
 
SELECT 
    *
FROM
    RETAILSALES
WHERE
    CATEGORY = 'CLOTHING' AND QUANTITY >= 4
        AND YEAR(SALE_DATE) = 2022
        AND MONTH(SALE_DATE) = 11
;
    
# 3.WRITE A SQL QUERY TO CALCULATE TOTAL SALES (TOTAL_SALES) FOR EACH CATEGORY

SELECT 
    category, SUM(total_sale) AS net_sales
FROM
    retailsales
GROUP BY category;
 
# 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 

SELECT 
    AVG(age) AS Average_age
FROM
    retailsales
WHERE
    category = 'beauty';


# 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    transactions_id
FROM
    retailsales
WHERE
    total_sale > 1000;

# 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    gender, category, COUNT(transactions_id) AS total_trans
FROM
    retailsales
GROUP BY 1 , 2; 

# 7.Write a SQL query to calculate the average sale for each month.

SELECT 
year(sale_date) AS Year,
month(sale_date) AS Month ,
AVG(total_sale) AS avg_sale,
RANK() OVER (partition by year(sale_date) order by avg(total_sale) DESC) 
FROM retailsales
GROUP BY 1,2;


# 8.Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id, SUM(total_sale)
FROM
    retailsales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

# 9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    COUNT(DISTINCT customer_id), category
FROM
    retailsales
GROUP BY 2;


# 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
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

    

