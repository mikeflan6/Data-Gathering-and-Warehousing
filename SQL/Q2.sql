-- Join tables in a query
WITH sales_with_state AS (
    SELECT
        c.State,
        YEAR(STR_TO_DATE(s.sales_date, '%m/%d/%Y')) AS sales_year,
        s.sales_price
    FROM sales s
    JOIN customers c ON s.customer_id = c.id
    WHERE YEAR(STR_TO_DATE(s.sales_date, '%m/%d/%Y')) BETWEEN 2021 AND 2025
),
-- Get state totals from first queryand limit to the top 3 
state_totals AS (
    SELECT
        State,
        SUM(sales_price) AS total_sales
    FROM sales_with_state
    GROUP BY State
    ORDER BY total_sales DESC
    LIMIT 3
)
-- final query that gets annual sales for the states with the highest sales for the past 5 years
SELECT
    s.State,
    s.sales_year,
    COUNT(*) AS sales_count,
    SUM(s.sales_price) AS yearly_sales
FROM sales_with_state s
JOIN state_totals top_states ON s.State = top_states.State
GROUP BY s.State, s.sales_year
ORDER BY s.State, s.sales_year;
