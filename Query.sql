-- 1. What is the total amount each customer spent at the restaurant?
SELECT s.customer_id,
SUM(f.price) AS total_amount
FROM dannys_diner.sales AS s
LEFT JOIN dannys_diner.menu AS f 
ON s.product_id = f.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- Result:
| customer_id | total_amount |
| ----------- | --- |
| A           | 76  |
| B           | 74  |
| C           | 36  |


-- 2. How many days has each customer visited the restaurant?
SELECT s.customer_id,
COUNT(DISTINCT s.order_date) AS count_of_customer_visit
FROM dannys_diner.sales AS s
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- Result:
| customer_id | count_of_customer_visit |
| ----------- | ----------------------- |
| A           | 4                       |
| B           | 6                       |
| C           | 2                       |


-- 3. What was the first item from the menu purchased by each customer?
SELECT s.customer_id,
s.order_date,
s.product_id,
m.product_name
FROM dannys_diner.sales as s
LEFT JOIN dannys_diner.menu as m
ON s.product_id = m.product_id
WHERE order_date = (SELECT MIN(order_date) FROM dannys_diner.sales);

| customer_id | order_date | product_id | product_name |
| ----------- | ---------- | ---------- | ------------ |
| A           | 2021-01-01 | 1          | sushi        |
| A           | 2021-01-01 | 2          | curry        |
| B           | 2021-01-01 | 2          | curry        |
| C           | 2021-01-01 | 3          | ramen        |
| C           | 2021-01-01 | 3          | ramen        |


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name AS product_name,
m.product_id AS product_id,
COUNT(m.price) as order_times
FROM dannys_diner.sales AS s
LEFT JOIN dannys_diner.menu AS m
ON s.product_id = m.product_id
GROUP BY m.product_name, m.product_id
ORDER BY order_times DESC;

-- Result:
| product_name | product_id | order_times |
| ------------ | ---------- | ----------- |
| ramen        | 3          | 8           |
| curry        | 2          | 4           |
| sushi        | 1          | 3           |


-- 5. Which item was the most popular for each customer?


-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
