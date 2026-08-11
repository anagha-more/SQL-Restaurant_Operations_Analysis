select * from order_details;

# Question1
-- What is the date range of the table?

select min(order_date) as first_order_date , max(order_date)  as last_order_date
from order_details	
;

# Question2
-- How many orders were made within this date range? How many items were ordered within this date range?

select count(distinct order_id) as orders_made_count, count(item_id) as items_ordered_count
from order_details
;
 
# Question3 
-- Which orders had the most number of items?
with cte as(
select order_id, count(item_id) as total_items
from order_details
group by order_id
)
select order_id, total_items from (
select *, dense_rank() over(order by total_items desc) as dr
from cte)x
where x.dr =1
;

# Question4
-- How many orders had more than 12 items?

select count(*) as orders_with_more_items from (
select order_id, count(item_id) as total_items
from order_details
group by order_id
having total_items > 12
)x
