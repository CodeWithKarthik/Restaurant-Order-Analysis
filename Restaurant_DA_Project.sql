Use restaurant_db;
 
 -- Obejective 1:
 
-- 1. View the menu table
Select * from menu_items;

-- 2. Find the number of items on the menu
Select Count(*) from menu_items;

-- 3. What are the least and most expensive item on the menu
Select * from menu_items
order by price asc;

Select * from menu_items
order by price desc;

-- 4. How many Italian dishes are on the menu
select Count(*) from menu_items
where category = 'Italian';

-- 5. What are least and most expensive Italian dishes on the menu
 Select * from menu_items
 where category = 'Italian'
order by price asc;

Select * from menu_items
where category = 'Italian'
order by price desc;

-- 6. How many dishes are in each category
SELECT category, COUNT(category) AS num_dishes
FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;

-- Objective 2:

-- 1. View the order_details table.
Select * from order_details; 

-- 2. What is the date range of the table
Select * from order_details
order by order_date;

select min(order_date) from order_details;

select max(order_date) from order_details;

-- 3. How many orders were made within this date range
Select count(distinct order_id) from order_details;

-- 4. How many items were ordered within this date range
Select count(*) from order_details;

-- 5. Which orders had the most number of items
Select order_id, Count(item_id) as num_items  from order_details
group by order_id
order by num_items desc;

Select order_id, Count(item_id) as num_items  from order_details
group by order_id
order by num_items;

-- 6 How many orders had more than 12 items
Select order_id, Count(item_id) as num_items  from order_details
group by order_id
Having num_items > 12;

Select Count(*) from 
(Select order_id, Count(item_id) as num_items  from order_details
group by order_id
Having num_items > 12) as Num_orders;

-- Objective 3:

-- 1. Combine the menu_items and order_details tables into a single table.
SELECT * From order_details
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_details_id) AS num_purchases FROM order_details
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;

SELECT item_name, category, COUNT(order_details_id) AS num_purchases FROM order_details
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases;

-- 3.  What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spend FROM order_details  
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. View the details of the highest spend order. What insights can you gather from the results
SELECT category, COUNT(item_id) AS num_items FROM order_details  
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- 5. View the details of the top 5 highest spend order. What insights can you gather from the results
SELECT order_id, category, COUNT(item_id) AS num_items FROM order_details 
LEFT JOIN menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;