-------------------------------------------------
1. What is the total amount each customer spent at the restaurant?

SELECT <br/>
  	customer_id,<br/>
    SUM(m.price) AS total_amount<br/>
FROM dannys_diner.menu m<br/>
JOIN dannys_diner.sales s<br/>
ON s.product_id = m.product_id<br/>
GROUP BY customer_id<br/>
ORDER BY customer_id;

![Screen Shot 2022-03-24 at 2 28 35 PM](https://user-images.githubusercontent.com/85157023/159823872-f16a476b-400b-45f1-94ae-091f385eeaa3.png)



------------------------------------------------

2. How many days has each customer visited the restaurant?

SELECT<br/>
  	customer_id,<br/>
    COUNT(DISTINCT order_date) as num_days<br/>
FROM dannys_diner.sales<br/>
GROUP BY customer_id;

![Screen Shot 2022-03-24 at 2 29 50 PM](https://user-images.githubusercontent.com/85157023/159824001-2c09839b-6b91-445c-a344-c12c22664e18.png)

-------------------------------------------------

3. What was the first item from the menu purchased by each customer?

SELECT *<br/>
FROM <br/>
(SELECT s.customer_id, m.product_name,<br/>
        ROW_NUMBER () OVER (PARTITION BY s.customer_id ORDER BY s.order_date, s.product_id) first_item<br/>
 FROM dannys_diner.sales s, dannys_diner.menu m<br/>
 WHERE s.product_id = m.product_id) t<br/>
 WHERE first_item = 1;
 
 ![3](https://user-images.githubusercontent.com/85157023/159826650-35a4b2f8-7066-46f3-b3c5-7ecbfc37e8b8.png)


--------------------------------------------------

4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT<br/>
  	m.product_name,<br/>
    COUNT(s.product_id) AS most_purchased<br/>
FROM dannys_diner.menu m<br/>
JOIN dannys_diner.sales s<br/>
ON s.product_id = m.product_id<br/>
GROUP BY m.product_name<br/>
ORDER BY most_purchased DESC<br/>
LIMIT 1;

![4](https://user-images.githubusercontent.com/85157023/159826633-6a8f2acb-cb3a-490c-9537-bd4309c40d38.png)


-----------------------------------------------------

5. Which item was the most popular for each customer?

SELECT<br/>
  	s.customer_id, <br/>
    m.product_name,<br/>
    count(m.product_name) as most_popular<br/>
    FROM dannys_diner.menu m<br/>
          JOIN dannys_diner.sales s<br/>
          ON s.product_id = m.product_id<br/>
GROUP BY s.customer_id, m.product_name<br/>
ORDER BY most_popular DESC;


![Screen Shot 2022-03-24 at 2 58 23 PM](https://user-images.githubusercontent.com/85157023/159826788-a1dfd924-9e16-4517-b2ac-8e320b6a2d5d.png)


----------------------------------------------------

6. Which item was purchased first by the customer after they became a member?

SELECT *<br/>
FROM <br/>
(SELECT<br/>
    s.customer_id,ms.join_date,m.product_name,<br/>
        ROW_NUMBER () OVER (PARTITION BY s.customer_id ORDER BY s.order_date) first_item<br/>
 FROM dannys_diner.sales s<br/>
 JOIN dannys_diner.members ms<br/>
 ON ms.customer_id = s.customer_id<br/>
 JOIN dannys_diner.menu m<br/>
 ON s.product_id = m.product_id<br/>
 WHERE s.order_date >= ms.join_date) t<br/>
 WHERE first_item = 1;
 
 ![6](https://user-images.githubusercontent.com/85157023/159826602-e2c55c0c-b56b-42ba-8b48-4729c3db7390.png)

 
--------------------------------------------------
 
 7. Which item was purchased just before the customer became a member?
 
 SELECT *<br/>
FROM <br/>
(SELECT<br/>
    s.customer_id,s.order_date,m.product_name,<br/>
        RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date DESC) items<br/>
 FROM dannys_diner.sales s<br/>
 JOIN dannys_diner.members ms<br/>
 ON ms.customer_id = s.customer_id<br/>
 JOIN dannys_diner.menu m<br/>
 ON s.product_id = m.product_id<br/>
 WHERE s.order_date < ms.join_date) t<br/>
 WHERE items = 1;
 
 ![7](https://user-images.githubusercontent.com/85157023/159826591-2d22eed7-e33b-403e-9c9f-3ce17b4208c2.png)

 
 -----------------------------------------------
 
8. What is the total items and amount spent for each member before they became a member?

SELECT 
    s.customer_id,<br/>
    COUNT(DISTINCT s.product_id) AS total_items,<br/>
    SUM(m.price) AS total_amount<br/>
 FROM dannys_diner.sales s<br/>
 JOIN dannys_diner.members ms<br/>
 ON ms.customer_id = s.customer_id<br/>
 JOIN dannys_diner.menu m<br/>
 ON s.product_id = m.product_id<br/>
 WHERE s.order_date < ms.join_date<br/>
 GROUP BY s.customer_id;
 
 ![8](https://user-images.githubusercontent.com/85157023/159826565-124b13a8-1b19-4844-ac10-4e66aa2da91e.png)

 
 
 -------------------------------------------
 
 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
 
 WITH points AS ( <br/>
     SELECT* , <br/>
     CASE WHEN product_id = 1 THEN price* 20 <br/>
     ELSE price* 10<br/>
     END AS points<br/>
     FROM dannys_diner.menu )<br/>
SELECT s.customer_id, SUM(p.points) AS total_points<br/>
FROM dannys_diner.sales s<br/>
JOIN points p<br/>
ON p.product_id = s.product_id<br/>
GROUP BY s.customer_id<br/>
ORDER BY s.customer_id;

![9](https://user-images.githubusercontent.com/85157023/159826549-0c0ee5fc-1577-40c0-b5e5-eff6a7fb2cbb.png)


--------------------------------------

10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

SELECT customer_id, SUM(total_points)<br/>
FROM <br/>
(WITH points AS<br/>
(<br/>
SELECT s.customer_id, <br/>
	(s.order_date - ms.join_date) AS first_week,<br/>
        m.price,<br/>
        m.product_name,<br/>
        s.order_date<br/>
    FROM dannys_diner.sales s<br/>
	JOIN dannys_diner.menu m <br/>
    ON s.product_id = m.product_id<br/>
	JOIN dannys_diner.members AS ms<br/>
	ON ms.customer_id = s.customer_id<br/>
    )<br/>
SELECT customer_id,<br/>
		CASE <br/>
		WHEN first_week BETWEEN 0 AND 7 THEN price * 20<br/>
        WHEN (first_week > 7 OR first_week < 0) AND product_name = 'sushi' THEN price * 20<br/>
		WHEN (first_week > 7 OR first_week < 0) AND product_name != 'sushi' THEN price * 10<br/>
        END AS total_points,<br/>
        order_date<br/>
FROM points<br/>
WHERE EXTRACT(MONTH FROM order_date) = 1) as t<br/>
GROUP BY customer_id<br/>
ORDER BY customer_id;

![10](https://user-images.githubusercontent.com/85157023/159826529-b6534393-7bcf-4404-87b9-da565462f477.png)


 ---------------------------------------------
 BONUS QUESTION -  JOIN ALL THE THINGS
 
 WITH join_all AS <br/>
(<br/>
 SELECT s.customer_id, s.order_date, m.product_name, m.price,<br/>
  CASE<br/>
  WHEN ms.join_date > s.order_date THEN 'N'<br/>
  WHEN ms.join_date <= s.order_date THEN 'Y'<br/>
  ELSE 'N' END AS m<br/>
 FROM dannys_diner.sales AS s<br/>
 LEFT JOIN dannys_diner.menu AS m<br/>
  ON s.product_id = m.product_id<br/>
 LEFT JOIN dannys_diner.members AS ms<br/>
  ON s.customer_id = ms.customer_id<br/>
)<br/>
SELECT *, CASE<br/>
 WHEN m = 'N' then NULL<br/>
 ELSE<br/>
  RANK () OVER(PARTITION BY customer_id, m<br/>
  ORDER BY order_date) END AS ranking<br/>
FROM join_all;


 
 
 ![11](https://user-images.githubusercontent.com/85157023/159826502-28535da8-ffa7-4b9b-a101-df8f04f6a319.png)

 






