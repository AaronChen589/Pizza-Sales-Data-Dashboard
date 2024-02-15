-- find the total revenue earned from pizza sales
SELECT 
	SUM(total_price) AS total_revenue
FROM pizza_sales;

--  find the average ordering price per customer
SELECT 
	SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_price
FROM pizza_sales;

-- find the total number of pizzas sold
SELECT 
	SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- find the total number of orders
SELECT 
	COUNT(DISTINCT order_id)
FROM pizza_sales;

-- find the average number of pizzas per order (rounded to hundreth place)
SELECT 
	ROUND(SUM(quantity)::decimal / COUNT(DISTINCT order_id)::decimal, 2) AS avg_pizzas_per_order
FROM pizza_sales;

-- find the number of pizzas sold per hour
SELECT 
	EXTRACT(HOUR FROM order_time::time) AS order_hour,
	SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY order_hour
ORDER BY order_hour;

-- find the number of orders per week 
SELECT 
	EXTRACT(WEEK FROM TO_DATE(order_date, 'MM/DD/YY')) AS week_number,
	EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YY')) AS year,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY week_number, year
ORDER BY year, week_number;

-- find the total revenue per category
SELECT
	pizza_category,
	ROUND(SUM(total_price::decimal),2) AS total_revenue,	
	ROUND(SUM(total_price::decimal) * 100 / 
    (SELECT SUM(total_price)::decimal FROM pizza_sales),2) AS percentage	
FROM pizza_sales
GROUP BY pizza_category
ORDER BY percentage DESC;

-- find the total revenue per pizza size
SELECT
	pizza_size,
	ROUND(SUM(total_price::decimal),2) AS total_revenue,	
	ROUND(SUM(total_price::decimal) * 100 / 
    (SELECT SUM(total_price)::decimal FROM pizza_sales),2) AS percentage	
FROM pizza_sales
GROUP BY pizza_size
ORDER BY percentage DESC;

-- find the total number of pizza sold per category 
SELECT 
	pizza_category, SUM(quantity) as total_quantity_sold
FROM pizza_sales 
GROUP BY pizza_category 
ORDER BY total_quantity_sold DESC;

--  find the 5 most profitable pizzas
SELECT 
	pizza_name,
	SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_revenue DESC
limit 5

--  find the 5 least profitable pizzas
SELECT 
	pizza_name,
	SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_revenue ASC
limit 5

-- find the 5 most selling pizzas
SELECT 
	pizza_name,
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
limit 5

-- find the 5 worst selling pizzas
SELECT 
	pizza_name,
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
limit 5;

-- find the 5 best pizzas by total order
SELECT 
	pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
limit 5;

-- find the 5 worse pizzas by total order
SELECT 
	pizza_name,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
limit 5;
