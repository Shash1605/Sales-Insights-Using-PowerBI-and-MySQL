use sales;
select * from combined;

## 1. Total Sales
SELECT SUM(norm_sales_amount) AS total_sales 
FROM combined;

## 2. Number of Unique Customers
SELECT COUNT(DISTINCT customer_code) AS unique_customers
FROM combined;

## 3. Total Sales by Product type
SELECT product_type, SUM(norm_sales_amount) AS total_sales
FROM combined
GROUP BY product_type;

## 4. Average Sales done by each customer
SELECT customer_code,AVG(norm_sales_amount) AS avg_sales_per_customer
FROM combined
group by customer_code order by customer_code;

## 5. Total Sales done by each zone
SELECT zone, SUM(norm_sales_amount) from combined
group by zone;

## 6. Total Sales done by each city
SELECT markets_name, SUM(norm_sales_amount) from combined
group by markets_name;

## 5. Top 5 cities by sales
SELECT markets_name, SUM(norm_sales_amount)Total_Sales from combined
group by markets_name order by Total_Sales desc LIMIT 5;

## 6. Top Selling Products
SELECT product_code,product_type, SUM(sales_amount) AS total_sales
FROM combined
GROUP BY 1,2
ORDER BY total_sales DESC
LIMIT 5;

## 7. Sales Trend over time
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month, SUM(sales_amount) AS total_sales
FROM combined
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY 1,2;

## 8. Customers who have done the sales more than 50000
SELECT customer_code, SUM(sales_amount) AS total_spent
FROM combined
GROUP BY customer_code
HAVING SUM(sales_amount) > 50000;

## 9. Ranking Products by Sales Amount
SELECT product_code, SUM(norm_sales_amount)Total_Sales,
RANK() OVER (ORDER BY SUM(norm_sales_amount) DESC) AS product_rank
FROM combined group by 1;

## 10. Ranking Products by Sales Amount within a date range
SELECT product_code,order_date,norm_sales_amount,
RANK() OVER (PARTITION BY YEAR(order_date) ORDER BY norm_sales_amount DESC) AS yearly_rank
FROM combined
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31';

## 11. Ranking Years by Total Sales
SELECT year(order_date),SUM(norm_sales_amount),
RANK() OVER(ORDER BY SUM(norm_sales_amount) DESC) as Rnk
FROM combined group by 1;

## 12. Identifying Slow-Moving Products
SELECT product_code, SUM(sales_qty) AS total_sold
FROM combined
GROUP BY product_code
HAVING SUM(sales_qty) < 10;