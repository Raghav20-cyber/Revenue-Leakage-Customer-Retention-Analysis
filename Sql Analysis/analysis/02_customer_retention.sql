-- ============================================================
-- Analysis 02: Customer Retention & Lifetime Value
-- Database: cus_retention
-- Author: Raghav Sharma
-- Description: Analyzes customer purchase behaviour, lifetime
--              value, retention windows, and cohort activity.
-- ============================================================

USE cus_retention;

-- ------------------------------------------------------------
-- 1. Customer first and last purchase dates
--    Business question: How long has each customer been active?
-- ------------------------------------------------------------
SELECT 
    customer_id,
    MIN(order_date)                          AS first_purchase,
    MAX(order_date)                          AS last_purchase,
    DATEDIFF(MAX(order_date), MIN(order_date)) AS active_days
FROM transactions
GROUP BY customer_id
ORDER BY active_days DESC;


-- ------------------------------------------------------------
-- 2. Repeat purchase behaviour
--    Business question: Who are our most loyal customers?
-- ------------------------------------------------------------
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM transactions
GROUP BY customer_id
ORDER BY total_orders DESC;


-- ------------------------------------------------------------
-- 3. Customer Lifetime Value (CLV)
--    Business question: Which customers generate the most revenue and profit?
-- ------------------------------------------------------------
SELECT 
    customer_id,
    ROUND(SUM(sales), 2)  AS total_spent,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(order_id)        AS total_orders,
    ROUND(AVG(sales), 2)  AS avg_order_value
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC;


-- ------------------------------------------------------------
-- 4. Cohort retention analysis
--    Business question: Do customers acquired in early months retain better?
-- ------------------------------------------------------------
SELECT 
    DATE_FORMAT(first_order, '%Y-%m') AS cohort_month,
    DATE_FORMAT(order_date, '%Y-%m')  AS activity_month,
    COUNT(DISTINCT customer_id)        AS active_users
FROM (
    SELECT 
        t.*,
        MIN(order_date) OVER (PARTITION BY customer_id) AS first_order
    FROM transactions t
) sub
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;


-- ------------------------------------------------------------
-- 5. Customer stage value: are older customers more valuable?
--    Business question: Do long-term customers spend more and generate more profit?
-- ------------------------------------------------------------
SELECT 
    CASE 
        WHEN DATEDIFF(t.order_date, c.join_date) <= 30  THEN '1. New Customer (0-30 days)'
        WHEN DATEDIFF(t.order_date, c.join_date) <= 180 THEN '2. Mid-Term Customer (31-180 days)'
        ELSE                                                  '3. Old Customer (180+ days)'
    END AS customer_stage,

    COUNT(DISTINCT t.customer_id) AS total_customers,
    ROUND(SUM(t.sales), 2)        AS total_revenue,
    ROUND(AVG(t.sales), 2)        AS avg_order_value,
    ROUND(SUM(t.profit), 2)       AS total_profit,
    ROUND(SUM(t.profit) / SUM(t.sales) * 100, 2) AS profit_margin_pct

FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY customer_stage
ORDER BY customer_stage;
