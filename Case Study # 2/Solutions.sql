# Data Cleaning

After investigating the date, I found that some tables need cleaning and transforming to do.

Tables that need cleaning are - customer_orders, runner_orders and pizza_runner.

customer_orders: 


We need to replace null, NULL or NA values with empty or ‘ ‘

UPDATE customer_orders 
SET exclusions = '' 
WHERE exclusions = 'null' or exclusions LIKE 'null';

UPDATE customer_orders 
SET extras = '' 
WHERE extras IS 'null' or extras IS NULL;

SELECT * FROM customer_orders 







