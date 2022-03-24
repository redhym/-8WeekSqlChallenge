1. How many pizzas were ordered?

  SELECT COUNT(pizza_id) total_pizzas
  FROM pizza_runner.customer_orders;
  
  ![Screen Shot 2022-03-24 at 11 28 33 AM](https://user-images.githubusercontent.com/85157023/159806628-22059fd2-7b65-491c-8c2a-20f58519eca7.png)


2. How many unique customer orders were made?

  SELECT COUNT(DISTINCT order_id) unique_orders
  FROM pizza_runner.customer_orders;
  
  ![Screen Shot 2022-03-24 at 11 31 09 AM](https://user-images.githubusercontent.com/85157023/159806942-d861a853-0fe8-4ab4-a2a6-431845d6f07e.png)
  
3. How many successful orders were delivered by each runner?

   SELECT runner_id, COUNT(order_id) successful_orders
   FROM pizza_runner.runner_orders
   WHERE distance != ''
   GROUP BY runner_id;

![Screen Shot 2022-03-24 at 11 39 25 AM](https://user-images.githubusercontent.com/85157023/159807854-1d24cebe-b4c4-4998-b887-9f8a47b9e6ff.png)

4. How many of each type of pizza was delivered?

SELECT n.pizza_name, COUNT(c.order_id) successful_orders
FROM pizza_runner.customer_orders c
JOIN runner_orders as r
ON c.order_id = r.order_id
JOIN pizza_names as n
ON c.pizza_id = n.pizza_id
WHERE distance != ''
GROUP BY n.pizza_name;

![Screen Shot 2022-03-24 at 12 54 17 PM](https://user-images.githubusercontent.com/85157023/159815308-853848ea-688f-41ad-9ca1-cb679d25f385.png)

5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT c.customer_id, n.pizza_name, COUNT(n.pizza_id) pizza_ordered
FROM pizza_runner.customer_orders c
JOIN pizza_names as n
ON c.pizza_id = n.pizza_id
GROUP BY c.customer_id, n.pizza_name
ORDER BY c.customer_id;




