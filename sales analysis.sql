
Select MONTHNAME(order_date) as month,
ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue__usd
from overall
group by MONTHNAME(order_date);

Select product_name, SUM(quantity) AS total_quantity from overall group by product_name order by total_quantity Desc limit 10;

Select product_name,ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue__usd
from overall
group by product_name order by total_revenue__usd DESC;


Select storekey,ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue__usd
from overall
group by storekey order by total_revenue__usd DESC;

select * from overall