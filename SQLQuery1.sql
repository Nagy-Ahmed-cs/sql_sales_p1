use sql_project_1;
go

--inserting data in the sales table .........

truncate table sales;
BULK INSERT sales
FROM 'D:\SQL - Retail Sales Analysis_utf .csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


--test insertation of the data ....
select * from sales;
select count(*) as total_number_of_sales from sales;

--data cleaning here ...
select * from sales where cogs is null;


update sales set quantiy=4 where cogs is null; 

--test the cleaning .....
delete from sales where cogs is null ;

--data exploration .....

--how many sales we have ? 
select count(*) as total_sales from sales ;

--how many cusotmers do we have ? 
select distinct * from sales; --distinct orders .
select count(distinct customer_id)as number_of_customers  from sales ; -- the correct number of the customers .
select count( customer_id) from sales ;--the number of operations that custoners do . 
--how many category we have ? 
select count(distinct category )as categories_in_system from sales ; --unique categories here .
select distinct category from sales ;

-- business key problems & data analysis..

--write a query to retrive the sales made on '2022-11-05'
select * from sales where sale_date = '2022-11-05';


select count(distinct sale_date)/30 from sales;
-- study the duration of sales ...
select min(sale_date) as start_date , max(sale_date) as end_date from sales ;

select * from sales where quantiy >3 and category ='Clothing' order by customer_id asc;

select category , sum(quantiy)as total_amount from sales group by category;

--write the total sale for each category 
select category , sum(total_sale)as total_sale,count(*) as total_orders from sales group by category;
-- the avarage age of customers who bought from beauity category 

select avg(age) as avg_age from sales where category ='Beauty';
-- the sales of each gender in Beauty section ....
select gender ,category ,sum(total_sale) as total_sale from sales
where category ='Beauty'
group by gender,category ;

--toatal number of transcations made by each geneder in each category 
select category ,gender,count(transactions_id)as total_transcations,
sum(total_sale)as total_sale_each_gender_category
from sales group by category , gender ;
-- get the top customers ..
select customer_id , sum(total_sale) as total_sale from sales 
group by customer_id order by total_sale desc ;


--end of the project here ........