select * from menu_items;
select * from order_details;

# Question1
-- Combine the menu_items and order_details tables into a single table

select od.*, mi.item_name, mi.category, mi.price
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id	;

# Question2 
-- What were the least and most ordered items? What categories were they in?

select od.item_id, mi.item_name as most_ordered_product ,count(*) as total_orders
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id
group by item_id
order by total_orders desc limit 1
;

select od.item_id, mi.item_name as least_ordered_product ,count(*) as total_orders
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id
group by item_id
order by total_orders limit 1
;

# Question3
-- What were the top 5 orders that spent the most money?

select od.order_id , sum(mi.price) as total_order_price
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id
group by od.order_id
order by total_order_price desc 
limit 5
;

# Question4
-- view the details of the highest spend order. Which specific items were purchased?
with cte as(
select od.order_id, mi.item_name, mi.menu_item_id, mi.price ,sum(price) over(partition by od.order_id) as total_order_price
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id
)
select order_id, item_name, menu_item_id, price from (
select *, dense_rank() over(order by total_order_price desc) as dr
from cte)x
where x.dr =1
;

# Question5 
-- View the details of the top 5 highest spend orders

with cte as(
select od.order_id, mi.item_name, mi.menu_item_id, mi.price ,sum(price) over(partition by od.order_id) as total_order_price
from order_details od join menu_items mi
on od.item_id = mi.menu_item_id
)
select * from (
select *, dense_rank() over(order by total_order_price desc) as highest_order_rank
from cte)x
where x.highest_order_rank <=5
;