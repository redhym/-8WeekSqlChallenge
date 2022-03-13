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

6. Which item was purchased first by the customer after they became a member?

SELECT *
FROM 
(SELECT
    s.customer_id,ms.join_date,m.product_name,
        ROW_NUMBER () OVER (PARTITION BY s.customer_id ORDER BY s.order_date) first_item
 FROM dannys_diner.sales s
 JOIN dannys_diner.members ms
 ON ms.customer_id = s.customer_id
 JOIN dannys_diner.menu m
 ON s.product_id = m.product_id
 WHERE s.order_date >= ms.join_date) t
 WHERE first_item = 1;
 
--------------------------------------------------
 
 7. Which item was purchased just before the customer became a member?
 
 SELECT *
FROM 
(SELECT
    s.customer_id,s.order_date,m.product_name,
        RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date DESC) items
 FROM dannys_diner.sales s
 JOIN dannys_diner.members ms
 ON ms.customer_id = s.customer_id
 JOIN dannys_diner.menu m
 ON s.product_id = m.product_id
 WHERE s.order_date < ms.join_date) t
 WHERE items = 1;
 
 -----------------------------------------------
 
8. What is the total items and amount spent for each member before they became a member?

SELECT 
    s.customer_id,
    COUNT(DISTINCT s.product_id) AS total_items,
    SUM(m.price) AS total_amount
 FROM dannys_diner.sales s
 JOIN dannys_diner.members ms
 ON ms.customer_id = s.customer_id
 JOIN dannys_diner.menu m
 ON s.product_id = m.product_id
 WHERE s.order_date < ms.join_date
 GROUP BY s.customer_id;
 
 -------------------------------------------
 
 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
 
 WITH points AS (
     SELECT *,
     CASE WHEN product_id = 1 THEN price*20
     ELSE price*10
     END AS points
     FROM dannys_diner.menu )
SELECT s.customer_id, SUM(p.points) AS total_points
FROM dannys_diner.sales s
JOIN points p
ON p.product_id = s.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

--------------------------------------

10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

SELECT customer_id, SUM(total_points)
FROM 
(WITH points AS
(
SELECT s.customer_id, 
	(s.order_date - ms.join_date) AS first_week,
        m.price,
        m.product_name,
        s.order_date
    FROM dannys_diner.sales s
	JOIN dannys_diner.menu m 
    ON s.product_id = m.product_id
	JOIN dannys_diner.members AS ms
	ON ms.customer_id = s.customer_id
    )
SELECT customer_id,
		CASE 
		WHEN first_week BETWEEN 0 AND 7 THEN price * 20
        WHEN (first_week > 7 OR first_week < 0) AND product_name = 'sushi' THEN price * 20
		WHEN (first_week > 7 OR first_week < 0) AND product_name != 'sushi' THEN price * 10
        END AS total_points,
        order_date
FROM points
WHERE EXTRACT(MONTH FROM order_date) = 1) as t
GROUP BY customer_id
ORDER BY customer_id;

 

 
 
 
 






