A. Pizza Metrics

1. How many pizzas were ordered?

  SELECT COUNT(pizza_id) total_pizzas<br/>
  FROM pizza_runner.customer_orders;
  
  ![Screen Shot 2022-03-24 at 11 28 33 AM](https://user-images.githubusercontent.com/85157023/159806628-22059fd2-7b65-491c-8c2a-20f58519eca7.png)


2. How many unique customer orders were made?

  SELECT COUNT(DISTINCT order_id) unique_orders<br/>
  FROM pizza_runner.customer_orders;
  
  ![Screen Shot 2022-03-24 at 11 31 09 AM](https://user-images.githubusercontent.com/85157023/159806942-d861a853-0fe8-4ab4-a2a6-431845d6f07e.png)
  
3. How many successful orders were delivered by each runner?

   SELECT runner_id, COUNT(order_id) successful_orders<br/>
   FROM pizza_runner.runner_orders<br/>
   WHERE distance != ''<br/>
   GROUP BY runner_id;

![Screen Shot 2022-03-24 at 11 39 25 AM](https://user-images.githubusercontent.com/85157023/159807854-1d24cebe-b4c4-4998-b887-9f8a47b9e6ff.png)

4. How many of each type of pizza was delivered?

SELECT n.pizza_name, COUNT(c.order_id) successful_orders<br/>
FROM pizza_runner.customer_orders c<br/>
JOIN runner_orders as r<br/>
ON c.order_id = r.order_id<br/>
JOIN pizza_names as n<br/>
ON c.pizza_id = n.pizza_id<br/>
WHERE distance != ''<br/>
GROUP BY n.pizza_name;

![Screen Shot 2022-03-24 at 12 54 17 PM](https://user-images.githubusercontent.com/85157023/159815308-853848ea-688f-41ad-9ca1-cb679d25f385.png)

5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT c.customer_id, n.pizza_name, COUNT(n.pizza_id) pizza_ordered<br/>
FROM pizza_runner.customer_orders c<br/>
JOIN pizza_names as n<br/>
ON c.pizza_id = n.pizza_id<br/>
GROUP BY c.customer_id, n.pizza_name<br/>
ORDER BY c.customer_id;

![Screen Shot 2022-03-24 at 1 00 43 PM](https://user-images.githubusercontent.com/85157023/159815837-8328fbbd-48ef-44d4-b079-a3a2562e7677.png)

6. What was the maximum number of pizzas delivered in a single order?

SELECT r.order_id, COUNT(c.pizza_id) max_delivered<br/>
FROM pizza_runner.runner_orders r<br/>
JOIN customer_orders c<br/>
ON c.order_id = r.order_id<br/>
WHERE distance != '' <br/>
GROUP BY r.order_id<br/>
ORDER BY max_delivered DESC<br/>
LIMIT 1;

![Screen Shot 2022-03-24 at 1 39 13 PM](https://user-images.githubusercontent.com/85157023/159819202-73175fc4-7f4a-4d8f-bb68-d0f48fa6acc1.png)

7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT c.customer_id, <br/>
SUM(<br/>
   CASE WHEN c.exclusions != '' OR c.extras != '' THEN 1<br/>
   ELSE 0<br/>
   END) AS at_least_1_change,<br/>
 SUM(<br/>
     CASE WHEN c.exclusions = '' OR c.extras = '' THEN 1<br/>
     ELSE 0<br/>
	END) AS no_change<br/>
FROM pizza_runner.customer_orders c<br/>
JOIN runner_orders r<br/>
ON c.order_id = r.order_id<br/>
WHERE r.distance != '' <br/>
GROUP BY c.customer_id<br/>
ORDER BY c.customer_id;

![Screen Shot 2022-03-24 at 1 52 29 PM](https://user-images.githubusercontent.com/85157023/159820472-55569ac9-bcc0-4326-beac-558e693e2468.png)

8. How many pizzas were delivered that had both exclusions and extras?


