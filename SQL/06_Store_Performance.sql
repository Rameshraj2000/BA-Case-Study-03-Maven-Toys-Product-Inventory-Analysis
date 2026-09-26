use maven_toys;

SELECT
    COUNT(DISTINCT s.Store_ID) AS store_count,
    SUM(s.Units) AS total_units_sold,
    SUM(s.Units * p.Product_Price) AS total_revenue,
    SUM(s.Units * (p.Product_Price - p.Product_Cost)) AS total_gross_profit,
    ROUND(
        SUM(s.Units * (p.Product_Price - p.Product_Cost))
        / SUM(s.Units * p.Product_Price) * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID;