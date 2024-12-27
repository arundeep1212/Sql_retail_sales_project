select * from retail_sales;

-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
    
    
    -- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(SALE_DATE, '%Y-%m') = '2022-11'
        AND quantiy >= 4
ORDER BY sale_date;


-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    COUNT(*) AS total_sales,
    SUM(total_sale) AS net_sale
FROM
    retail_sales
GROUP BY category;


-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    ROUND(AVG(age), 2)
FROM
    retail_sales
WHERE
    category = 'Beauty';
    
    
-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000
ORDER BY sale_date;


-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category, gender, COUNT(transactions_id)
FROM
    retail_sales
GROUP BY category , gender
ORDER BY category;


-- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year, month, highest_sale  from (select 
year(sale_date) as year,
month(sale_date) as month,
round(avg(total_sale),2) as highest_sale,
rank() over(partition by year(sale_date) order by round(avg(total_sale),2) desc) as rank1
from retail_sales
group by year, month) as a
where rank1 = 1;


-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as highest_sale from retail_sales
group by customer_id
order by highest_sale desc
limit 5;


-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    COUNT(DISTINCT customer_id) AS unique_customer, category
FROM
    retail_sales
WHERE
    quantiy IS NOT NULL
GROUP BY category;


-- Q10Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales 
as
(
SELECT 
    *,
    CASE
        WHEN hour(sale_time) < 12 THEN 'morning'
        WHEN hour(sale_time) BETWEEN '12' AND '17' THEN 'afternoon'
        ELSE 'evening'
    END AS shift
FROM
    retail_sales
)
select shift, count(*) as total_hours from hourly_sales
group by shift

    
    


