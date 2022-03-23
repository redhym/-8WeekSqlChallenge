# Data Cleaning

After investigating the date, I found that some tables need cleaning and transforming to do.

Tables that need cleaning are - customer_orders, runner_orders.

1.customer_orders: 

We need to replace null, NULL or NA values with empty or ‘ ‘

UPDATE customer_orders 
SET exclusions = '' 
WHERE exclusions = 'null' or exclusions LIKE 'null';

UPDATE customer_orders 
SET extras = '' 
WHERE extras IS 'null' or extras IS NULL;

SELECT * FROM customer_orders 

![Screen Shot 2022-03-23 at 3 17 29 PM](https://user-images.githubusercontent.com/85157023/159611295-8d048707-62c8-42b0-80d9-99662b2c07fa.png)

2. runner_orders

 UPDATE runner_orders 
 SET distance = '' 
 WHERE distance = 'null';
 SELECT * FROM runner_orders;
 
 UPDATE runner_orders 
SET distance = TRIM('km' from distance) 
WHERE distance LIKE '%km';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET pickup_time = '' 
WHERE pickup_time = 'null';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET duration = '' 
WHERE duration = 'null';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET duration = TRIM('min' from distance)
WHERE duration LIKE '%min';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET duration = TRIM('minute' from distance)
WHERE duration LIKE '%minute';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET duration = TRIM('minutes' from distance)
WHERE duration LIKE '%minutes';
SELECT * FROM runner_orders;

UPDATE runner_orders 
SET cancellation = '' 
WHERE cancellation = 'null' or cancellation IS NULL;
SELECT * FROM runner_orders;


![Screen Shot 2022-03-23 at 3 41 24 PM](https://user-images.githubusercontent.com/85157023/159613372-683dcab2-ca3c-4942-be51-67e4c3e689c6.png)









