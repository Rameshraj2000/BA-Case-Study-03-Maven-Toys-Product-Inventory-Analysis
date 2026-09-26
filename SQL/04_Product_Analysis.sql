use maven_toys;

SELECT
    p.Product_Category AS category,
    SUM(s.Units) AS units_sold,
    ROUND(SUM(s.Units * CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))), 2) AS revenue,
    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,
    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(s.Units * CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2)))
        * 100,
        2
    ) AS gross_margin_pct
FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY revenue DESC;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        )
        * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY revenue DESC
limit 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        )
        * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY units_sold DESC
limit 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,

    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ),
        2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ),
        2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ) * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY gross_profit DESC

LIMIT 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ) * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY revenue DESC

LIMIT 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ) * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY gross_profit DESC

LIMIT 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ) * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY gross_profit ASC

LIMIT 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Product_Category,
    SUM(s.Units) AS units_sold,

    ROUND(
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ), 2
    ) AS revenue,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        ), 2
    ) AS gross_profit,

    ROUND(
        SUM(
            s.Units *
            (
                CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
                -
                CAST(REPLACE(p.Product_Cost, '$', '') AS DECIMAL(10,2))
            )
        )
        /
        SUM(
            s.Units *
            CAST(REPLACE(p.Product_Price, '$', '') AS DECIMAL(10,2))
        ) * 100,
        2
    ) AS gross_margin_pct

FROM sales s
JOIN products p
    ON s.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Product_Category

ORDER BY gross_margin_pct ASC

LIMIT 10;