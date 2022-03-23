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

![Screen Shot 2022-03-23 at 3 17 29 PM](https://user-images.githubusercontent.com/85157023/159611295-8d048707-62c8-42b0-80d9-99662b2c07fa.png)






