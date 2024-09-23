
select
    CASE
        When square_meters < 250 Then '<250'
        When square_meters between 250 and 500  Then '250 to 500'
        When square_meters between 501 and 750  Then '500 to 750'
        When square_meters between 751 and 1000  Then '750 to 1000'
        When square_meters between 1001 and 1250  Then '1000 to 1250'
        When square_meters between 1251 and 1500  Then '1250 to 1500'
        When square_meters between 1501 and 1750  Then '1500 to 1750'
        When square_meters between 1751 and 2000  Then '1750 to 2000'
        When square_meters > 2000 Then '>2000'
    END AS size_bucket, ROUND(SUM((unit_price_usd)*quantity),2) AS total_sales
    from overall group by size_bucket 
    order by
      CASE
		When size_bucket = '<250' Then 1
        When size_bucket = '250 to 500' Then 2
        When size_bucket = '500 to 750' Then 3
        When size_bucket = '750 to 1000' Then 4
        When size_bucket = '1000 to 1250' Then 5
        When size_bucket = '1250 to 1500' Then 6
        When size_bucket ='1500 to 1750' Then 7
        When size_bucket = '1750 to 2000' Then 8
        When size_bucket =  '>2000' Then 9
        END;
        
select
     case
         when year(curdate()) - year(open_date) <=5 Then '<=5'
         when year(curdate()) - year(open_date) between 6 and 10 Then '5 to 10'
         when year(curdate()) - year(open_date) between 11 and 15 Then '11 to 15'
         when year(curdate()) - year(open_date) between 16 and 20 Then '16 to 20'
         END AS store_age_bucket,ROUND(SUM((unit_price_usd)*quantity),2) AS total_sales
         from overall
         group by store_age_bucket
         order by store_age_bucket;
         
 Select * from stores;  
 
 select storekey,country,continent,state,ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_usd
 from overall group by storekey,country,continent,state order by total_revenue_usd DESC;
    
         