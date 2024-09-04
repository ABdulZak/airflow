WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', purchase_date) AS month,
        SUM(total_amount) AS total_sales,
        COUNT(transaction_id) AS total_transactions
    FROM
        sales_transactions
    GROUP BY
        DATE_TRUNC('month', purchase_date)
),
moving_avg_sales AS (
    SELECT
        month,
        total_sales,
        total_transactions,
        AVG(total_sales) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS moving_avg_sales
    FROM
        monthly_sales
)
SELECT
    month,
    total_sales,
    total_transactions,
    moving_avg_sales
FROM
    moving_avg_sales
ORDER BY
    month;
