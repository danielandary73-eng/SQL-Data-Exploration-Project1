-- Q.1 write an sql query to retrieve all columns for sales made at '2022-11-05' 
SELECT * FROM retail_sales
where sale_date = '2022-11-05'; 

-- Q.2 write sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of nov , 2022

SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  AND quantity >= 4;




-- Q.3 write an sql query to calculate the total sales for each query ? 
select category,
sum(total_sale) AS net_sale,
count( * ) as total_orders
FROM retail_sales
Group by 1;

-- Q.4 write a sql query to find the average age of customers  who purchased items from the beauty categpry . 

select 
AVG(age)
from retail_sales 
where category = 'beauty' ;

-- Q.5 write an sql query to find all transactions where the total_sale is greater than 1000.

select * From
retail_sales where total_sale > 1000;

-- Q.6 write an sql query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,
count( * ) AS total_trans
from retail_sales
group by category , gender

-- Q.7 write an sql query to calculate the average sale for each month . find out best selling month in each year?

SELECT *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sales
    GROUP BY 1,2
) AS t1
WHERE sales_rank = 1;


-- Q.8 write sql query to find the top 5 customers based on the highest total sale.

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
 -- Q.9 write a sql query to find the number of unique customers who purchased items for each category
 
 SELECT 
	category,
    count(distinct customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q.10 write an sql query to create each shift and number of orders (example  moring <=12 , afternoon between 12 and 17 , evening  >17
WITH hourly_sale AS
(
    SELECT *,
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
            ELSE 'EVENING'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT