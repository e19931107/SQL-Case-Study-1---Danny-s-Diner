# SQL-Case_Study_1_Danny_s_Diner

![image](https://github.com/e19931107/SQL-Case-Study-1---Danny-s-Diner/assets/50692450/8da398ce-17df-401e-885f-9b8aaad46dff)

Link: https://8weeksqlchallenge.com/case-study-1/

## Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.
Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

## Problem Statement
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

sales
menu
members

## Example Datasets
All datasets exist within the dannys_diner database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.

**Schema (MySQL v8.0)**

-- Create the schema
CREATE SCHEMA dannys_diner;

-- Switch to the schema
USE dannys_diner;

-- Create the sales table
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INT
);

-- Insert data into the sales table
INSERT INTO sales (customer_id, order_date, product_id) VALUES
  ('A', '2021-01-01', 1),
  ('A', '2021-01-01', 2),
  ('A', '2021-01-07', 2),
  ('A', '2021-01-10', 3),
  ('A', '2021-01-11', 3),
  ('A', '2021-01-11', 3),
  ('B', '2021-01-01', 2),
  ('B', '2021-01-02', 2),
  ('B', '2021-01-04', 1),
  ('B', '2021-01-11', 1),
  ('B', '2021-01-16', 3),
  ('B', '2021-02-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-07', 3);

-- Create the menu table
CREATE TABLE menu (
  product_id INT,
  product_name VARCHAR(5),
  price INT
);

-- Insert data into the menu table
INSERT INTO menu (product_id, product_name, price) VALUES
  (1, 'sushi', 10),
  (2, 'curry', 15),
  (3, 'ramen', 12);

-- Create the members table
CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

-- Insert data into the members table
INSERT INTO members (customer_id, join_date) VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

---

### Table 1: sales
The sales table captures all customer_id level purchases with an corresponding order_date and product_id information for when and what menu items were ordered.

SELECT *
FROM dannys_diner.sales;

| customer_id | order_date | product_id |
| ----------- | ---------- | ---------- |
| A           | 2021-01-01 | 1          |
| A           | 2021-01-01 | 2          |
| A           | 2021-01-07 | 2          |
| A           | 2021-01-10 | 3          |
| A           | 2021-01-11 | 3          |
| A           | 2021-01-11 | 3          |
| B           | 2021-01-01 | 2          |
| B           | 2021-01-02 | 2          |
| B           | 2021-01-04 | 1          |
| B           | 2021-01-11 | 1          |
| B           | 2021-01-16 | 3          |
| B           | 2021-02-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-07 | 3          |


### Table 2: menu
The menu table maps the product_id to the actual product_name and price of each menu item.

SELECT *
FROM dannys_diner.menu;

| product_id | product_name | price |
| ---------- | ------------ | ----- |
| 1          | sushi        | 10    |
| 2          | curry        | 15    |
| 3          | ramen        | 12    |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/2rM8RAnq7h5LLDTzZiRWcd/6266)

### Table 3: members
The final members table captures the join_date when a customer_id joined the beta version of the Danny’s Diner loyalty program.

SELECT *
FROM dannys_diner.members;

| customer_id | join_date  |
| ----------- | ---------- |
| A           | 2021-01-07 |
| B           | 2021-01-09 |

