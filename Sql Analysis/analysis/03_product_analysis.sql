-- ============================================================
-- Analysis 03: Product Performance Analysis
-- Database: cus_retention
-- Author: Raghav Sharma
-- Description: Identifies best and worst performing products
--              by sales, profit, and discount behaviour.
-- ============================================================

USE cus_retention;

-- ------------------------------------------------------------
-- 1. Top 10 products by total sales
--    Business question: Which products drive the most revenue?
-- ------------------------------------------------------------
SELECT 
    product,
    ROUND(SUM(sales), 2)    AS total_sales,
    ROUND(SUM(profit), 2)   AS total_profit,
    COUNT(order_id)          AS total_orders,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct
FROM transactions
GROUP BY product
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 2. Bottom 10 products by profit margin (loss-risk SKUs)
--    Business question: Which products should be reviewed or discontinued?
-- ------------------------------------------------------------
SELECT 
    product,
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct
FROM transactions
GROUP BY product
ORDER BY profit_margin_pct ASC
LIMIT 10;


-- ------------------------------------------------------------
-- 3. Category-level revenue contribution
--    Business question: Which category leads revenue and profit?
-- ------------------------------------------------------------
SELECT 
    category,
    ROUND(SUM(sales), 2)   AS total_sales,
    ROUND(SUM(profit), 2)  AS total_profit,
    COUNT(order_id)         AS total_orders,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM transactions
GROUP BY category
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 4. City-level performance
--    Business question: Which cities generate the most profit?
-- ------------------------------------------------------------
SELECT 
    city,
    ROUND(SUM(sales), 2)   AS total_sales,
    ROUND(SUM(profit), 2)  AS total_profit,
    COUNT(order_id)         AS total_orders,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM transactions
GROUP BY city
ORDER BY total_profit DESC;
