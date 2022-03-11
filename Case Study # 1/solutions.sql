-------------------------------------------------
1. What is the total amount each customer spent at the restaurant?

SELECT
  	customer_id,
    SUM(m.price) AS total_amount
FROM dannys_diner.menu m
JOIN dannys_diner.sales s
ON s.product_id = m.product_id
GROUP BY customer_id
ORDER BY customer_id;


------------------------------------------------

2. How many days has each customer visited the restaurant?

SELECT
  	customer_id,
    COUNT(DISTINCT order_date) as num_days
FROM dannys_diner.sales
GROUP BY customer_id;

-------------------------------------------------

3. What was the first item from the menu purchased by each customer?

SELECT *
FROM 
(SELECT s.customer_id, m.product_name,
        ROW_NUMBER () OVER (PARTITION BY s.customer_id ORDER BY s.order_date, s.product_id) first_item
 FROM dannys_diner.sales s, dannys_diner.menu m
 WHERE s.product_id = m.product_id) t
 WHERE first_item = 1;

--------------------------------------------------

4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT
  	m.product_name,
    COUNT(s.product_id) AS most_purchased
FROM dannys_diner.menu m
JOIN dannys_diner.sales s
ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased DESC
LIMIT 1;

-----------------------------------------------------

5. Which item was the most popular for each customer?

SELECT
  	s.customer_id, 
    m.product_name,
    count(m.product_name) as most_popular
    FROM dannys_diner.menu m
          JOIN dannys_diner.sales s
          ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
ORDER BY most_popular DESC;

----------------------------------------------------







