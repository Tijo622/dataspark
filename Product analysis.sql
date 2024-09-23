Select * from products;

Select category, subcategory, ROUND(SUM(unit_price_usd * quantity),2) AS total_sales from overall 
group by category, subcategory order by total_sales DESC;

select distinct(product_name),sum(quantity) as Quantity
from overall group by product_name order by Quantity desc limit 10;

select product_name, ROUND(SUM((unit_price_usd-unit_cost_usd)*quantity),2) as Profit_Margin
from overall
group by product_name order by Profit_Margin desc limit 10