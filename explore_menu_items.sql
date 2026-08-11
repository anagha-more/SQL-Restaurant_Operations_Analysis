select * from menu_items;	

# Question1
# View the menu_items table and write a query to find the number of items on the menu
select count(menu_item_id)as total_menu_items from menu_items;

# Question2
# What are the least and most expensive items on the menu?
select item_name as least_expensive_item, menu_item_id, category, price
from menu_items
order by price limit 1
;
select item_name as most_expensive_item, menu_item_id, category, price
from menu_items
order by price desc limit 1
;

# Question3
# How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
select distinct category from menu_items;  -- to get category names

-- count of Italian dishes
select count(*) as Italian_dishes from menu_items
where category like "Italian";

-- least and most expensive Italian dish
select item_name , menu_item_id, category, price , 'least_expensive' as label from (
select * , dense_rank() over(order by price) as dr
from menu_items
where category like "Italian" )x
where x.dr =1;

select item_name , menu_item_id, category, price, 'Most_expensive' as label from (
select * , dense_rank() over(order by price desc) as dr
from menu_items
where category like "Italian" )x
where x.dr =1;

# Question4 
# How many dishes are in each category? What is the average dish price within each category?
select category, count(*) as total_dishes, avg(price) as avg_dish_price
from menu_items
group by category
;

# checking for duplicates if any
/*
select count(*) from menu_items
group by menu_item_id, item_name, category, price 
having count(*) > 1
;
*/

