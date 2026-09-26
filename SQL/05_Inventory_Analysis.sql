use maven_toys;
SELECT
    COUNT(*) AS inventory_rows,
    SUM(Stock_On_Hand) AS total_stock_units,
    SUM(CASE WHEN Stock_On_Hand = 0 THEN 1 ELSE 0 END) AS zero_stock_rows,
    MIN(Stock_On_Hand) AS minimum_stock,
    MAX(Stock_On_Hand) AS maximum_stock
FROM inventory;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS historical_units_sold,
    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand
FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category
ORDER BY historical_units_sold DESC;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN sales s
    ON i.Store_ID = s.Store_ID
    AND i.Product_ID = s.Product_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

ORDER BY days_of_supply ASC;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN sales s
    ON i.Store_ID = s.Store_ID
    AND i.Product_ID = s.Product_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

HAVING SUM(s.Units) > 0

ORDER BY days_of_supply ASC;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN sales s
    ON i.Store_ID = s.Store_ID
    AND i.Product_ID = s.Product_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

HAVING SUM(s.Units) > 0

ORDER BY days_of_supply ASC
LIMIT 20;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply,

    ROUND(
        i.Stock_On_Hand * p.Product_Cost,
        2
    ) AS inventory_value

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN sales s
    ON i.Store_ID = s.Store_ID
    AND i.Product_ID = s.Product_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand,
    p.Product_Cost

HAVING SUM(s.Units) > 0
   AND i.Stock_On_Hand > 0

ORDER BY days_of_supply DESC

LIMIT 20;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    COALESCE(SUM(s.Units), 0) AS historical_units_sold,

    ROUND(
        COALESCE(SUM(s.Units), 0) / 638,
        2
    ) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        CASE
            WHEN COALESCE(SUM(s.Units), 0) > 0
            THEN i.Stock_On_Hand / (SUM(s.Units) / 638)
            ELSE NULL
        END,
        2
    ) AS days_of_supply,

    ROUND(
        i.Stock_On_Hand * CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2)),
        2
    ) AS inventory_value

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

LEFT JOIN sales s
    ON i.Product_ID = s.Product_ID
    AND i.Store_ID = s.Store_ID

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand,
    p.Product_Cost

ORDER BY days_of_supply DESC;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

JOIN sales s
    ON i.Product_ID = s.Product_ID
    AND i.Store_ID = s.Store_ID

WHERE i.Stock_On_Hand = 0

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

HAVING SUM(s.Units) > 0

ORDER BY historical_units_sold DESC;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / (SUM(s.Units) / 638),
        2
    ) AS days_of_supply,

    ROUND(
        i.Stock_On_Hand *
        CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2)),
        2
    ) AS inventory_value

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

JOIN sales s
    ON i.Product_ID = s.Product_ID
    AND i.Store_ID = s.Store_ID

WHERE i.Stock_On_Hand > 0

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand,
    p.Product_Cost

HAVING SUM(s.Units) > 0

ORDER BY days_of_supply DESC

LIMIT 20;

SELECT
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units_sold,

    ROUND(SUM(s.Units) / 638, 2) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand / (SUM(s.Units) / 638),
        2
    ) AS days_of_supply,

    ROUND(
        i.Stock_On_Hand *
        CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2)),
        2
    ) AS inventory_value

FROM inventory i

JOIN products p
    ON i.Product_ID = p.Product_ID

JOIN stores st
    ON i.Store_ID = st.Store_ID

JOIN sales s
    ON i.Product_ID = s.Product_ID
    AND i.Store_ID = s.Store_ID

WHERE i.Stock_On_Hand > 0

GROUP BY
    i.Store_ID,
    st.Store_Name,
    st.Store_City,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand,
    p.Product_Cost

HAVING SUM(s.Units) > 0

ORDER BY inventory_value DESC

LIMIT 20;