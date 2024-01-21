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
WITH hot_selling_product_for_each_customer AS
(
   SELECT 
      s.customer_id, 
      m.product_name, 
      COUNT(m.product_id) AS order_count,
      DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.customer_id) DESC) AS `rank`
   FROM dannys_diner.menu AS m
   LEFT JOIN dannys_diner.sales AS s
      ON m.product_id = s.product_id
   GROUP BY s.customer_id, m.product_name
)

SELECT customer_id, product_name, order_count
FROM hot_selling_product_for_each_customer
WHERE `rank` = 1;

| customer_id | product_name | order_count |
| ----------- | ------------ | ----------- |
| A           | ramen        | 3           |
| B           | sushi        | 2           |
| B           | curry        | 2           |
| B           | ramen        | 2           |
| C           | ramen        | 3           |

WITH statement:
https://www.educba.com/mysql-with/

DENSE_RANK() function:
https://www.mysqltutorial.org/mysql-window-functions/mysql-dense_rank-function/


-- 6. Which item was purchased first by the customer after they became a member?
 with first_item_purchased_after_become_member_cte AS
 (
 SELECT s.customer_id, m.join_date, s.order_date, s.product_id,
 DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) AS ranking
 FROM dannys_diner.sales AS s
 LEFT JOIN dannys_diner.members AS m
 ON s.customer_id = m.customer_id
 WHERE s.order_date >= m.join_date
 )
 
 SELECT x.customer_id,
 x.join_date,
 x.order_date,
 x.product_id,
 m.product_name
 FROM first_item_purchased_after_become_member_cte AS x
 LEFT JOIN dannys_diner.menu AS m
 ON x.product_id = m.product_id
 WHERE ranking = '1';

| customer_id | join_date  | order_date | product_id | product_name |
| ----------- | ---------- | ---------- | ---------- | ------------ |
| A           | 2021-01-07 | 2021-01-07 | 2          | curry        |
| B           | 2021-01-09 | 2021-01-11 | 1          | sushi        |

-- https://www.db-fiddle.com/f/2rM8RAnq7h5LLDTzZiRWcd/6267

-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
