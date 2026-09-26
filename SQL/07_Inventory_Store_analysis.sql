use maven_toys;

SELECT
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units,

    ROUND(
        SUM(s.Units) / 638,
        2
    ) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand /
        NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply

FROM sales s

JOIN products p
    ON s.Product_ID = p.Product_ID

JOIN stores st
    ON s.Store_ID = st.Store_ID

JOIN inventory i
    ON s.Store_ID = i.Store_ID
    AND s.Product_ID = i.Product_ID

GROUP BY
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand

HAVING
    SUM(s.Units) > 0
    AND i.Stock_On_Hand = 0

ORDER BY
    historical_units DESC;
    
    
SELECT
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS historical_units,

    ROUND(
        SUM(s.Units) / 638,
        2
    ) AS avg_daily_demand,

    i.Stock_On_Hand AS current_stock,

    ROUND(
        i.Stock_On_Hand /
        NULLIF(SUM(s.Units) / 638, 0),
        2
    ) AS days_of_supply,

    ROUND(
        i.Stock_On_Hand *
        CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2)),
        2
    ) AS inventory_value

FROM sales s

JOIN products p
    ON s.Product_ID = p.Product_ID

JOIN stores st
    ON s.Store_ID = st.Store_ID

JOIN inventory i
    ON s.Store_ID = i.Store_ID
    AND s.Product_ID = i.Product_ID

GROUP BY
    st.Store_ID,
    st.Store_Name,
    st.Store_City,
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    p.Product_Cost,
    i.Stock_On_Hand

HAVING
    SUM(s.Units) > 0

ORDER BY
    days_of_supply DESC

LIMIT 15;