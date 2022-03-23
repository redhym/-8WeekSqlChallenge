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
   
   


