-- ============================================================
-- Analysis 04: Profitability & Margin Analysis
-- Database: cus_retention
-- Author: Raghav Sharma
-- Description: Overall business profitability, monthly trends,
--              and segment-level margin breakdown.
-- ============================================================

USE cus_retention;

-- ------------------------------------------------------------
-- 1. Overall profit margin
--    Business question: What is the business's current profit margin?
-- ------------------------------------------------------------
SELECT 
    ROUND(SUM(sales), 2)                          AS total_sales,
    ROUND(SUM(profit), 2)                         AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)      AS profit_margin_pct,
    COUNT(order_id)                                AS total_orders,
    ROUND(AVG(discount) * 100, 2)                 AS avg_discount_pct
FROM transactions;


-- ------------------------------------------------------------
-- 2. Monthly revenue and profit trend
--    Business question: Are there seasonal patterns in revenue or margin?
-- ------------------------------------------------------------
SELECT 
    DATE_FORMAT(order_date, '%Y-%m')              AS month,
    ROUND(SUM(sales), 2)                           AS total_sales,
    ROUND(SUM(profit), 2)                          AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)       AS profit_margin_pct,
    ROUND(AVG(discount) * 100, 2)                  AS avg_discount_pct
FROM transactions
GROUP BY month
ORDER BY month;


-- ------------------------------------------------------------
-- 3. Loss orders summary by category and city
--    Business question: Where are loss orders concentrated?
-- ------------------------------------------------------------
SELECT 
    category,
    city,
    COUNT(order_id)               AS loss_orders,
    ROUND(SUM(profit), 2)         AS total_loss,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct
FROM transactions
WHERE profit < 0
GROUP BY category, city
ORDER BY total_loss ASC;


-- ------------------------------------------------------------
-- 4. High-discount orders (>30%) and their profitability
--    Business question: Do orders with >30% discount always lose money?
-- ------------------------------------------------------------
SELECT 
    CASE 
        WHEN discount >= 0.30 THEN 'High Discount (>=30%)'
        WHEN discount >= 0.15 THEN 'Medium Discount (15-29%)'
        ELSE                       'Low Discount (<15%)'
    END AS discount_band,

    COUNT(order_id)                                   AS total_orders,
    ROUND(SUM(sales), 2)                              AS total_sales,
    ROUND(SUM(profit), 2)                             AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)          AS profit_margin_pct,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END)       AS loss_order_count

FROM transactions
GROUP BY discount_band
ORDER BY discount_band;
