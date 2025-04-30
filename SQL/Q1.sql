select
	right(s.sales_date,4) as sales_year,
    sum(s.sales_price) as Total_Sales
from sales s
Where right(s.sales_date,4) < 2025
group by right(s.sales_date,4) 
order by Total_Sales desc;

