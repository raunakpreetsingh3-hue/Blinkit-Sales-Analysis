use blinkit_project;

SELECT COUNT(*) 
FROM sales_data;

-- to check duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Product Name`, Category,Unit,Quantity,`original Price`,`Discount Amount`,`Discounted Price`) AS rn
FROM sales_data;

WITH duplicate_value AS(
		SELECT *,
		ROW_NUMBER() OVER(
        PARTITION BY `Product Name`, Category,Unit,Quantity,`original Price`,`Discount Amount`,`Discounted Price`) AS rn
        FROM sales_data
) SELECT * FROM 
duplicate_value 
where rn>1;    -- no duplicates found

-- to check null values

SELECT * FROM sales_data
where `Product Name` IS NULL OR Category IS NULL
 OR Unit IS NULL OR Quantity IS NULL OR
`original Price` IS NULL OR `Discount Amount`
 IS NULL OR `Discounted Price`IS NULL;

-- no null value is present

SELECT * FROM sales_data;


-- Data Analysis

SELECT COUNT(*)
FROM sales_data
where `Discount Amount`=0;

SELECT sum(`Discounted Price`) as revenue_for_non_discounted_items
FROM sales_data
where `Discount Amount`=0;

SELECT sum(`Discounted Price`) as Total_revenue
FROM sales_data;

select sum(`Discount Amount`) as Total_discount_provided
FROM sales_data;

select distinct unit 
from sales_data;

select * 
from sales_data
where `Discount Amount`>=`Original Price`;

select *
from sales_data
where round(`Original Price`-`Discounted Price`,2)!=round(`Discount Amount`,2);

alter table sales_data
add column Discount_amount double;

update sales_data
set discount_amount=round(`Original Price`-`Discounted Price`,2);

select *
from sales_data
where round(`Original Price`-`Discounted Price`,2)!=discount_amount;

alter table sales_data
drop column `Discount Amount`;

select sum(`Original Price`) as t_org_price
FROM sales_data;

select unit, count(*) as cnt
from sales_data
group by unit
order by cnt desc;

select distinct category
from sales_data;

select count(distinct category)
from sales_data;

select category, count(category)
from sales_data
group by category
order by count(category) desc;


select category, sum(`Discounted Price`) sum_of_dp,count(category)
from sales_data
group by category
order by sum_of_dp desc;

SELECT category,
ROUND(SUM(`Discounted Price`) / COUNT(*),2) AS avg_price
FROM sales_data
GROUP BY category
ORDER BY avg_price DESC;

UPDATE sales_data
SET category = 'Others'
WHERE category NOT IN (
    'Moisturisers And Serums',
    'Edible Oils & Ghee',
    'Shaving Care',
    'Dry Fruits',
    'Rice & Rice Products'
);































