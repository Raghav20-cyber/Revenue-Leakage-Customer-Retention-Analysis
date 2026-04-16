-- ============================================================
-- Analysis 01: Revenue Leakage Detection
-- Database: cus_retention
-- Author: Raghav Sharma
-- Description: Identifies products and orders responsible for
--              revenue leakage through excessive discounting
--              and negative profit margins.
-- ============================================================

USE cus_retention;

-- ------------------------------------------------------------
-- 1. Products with high average discount (> 10%)
--    sorted by worst profit first
--    Business question: Which products are being over-discounted?
-- ------------------------------------------------------------
SELECT 
    product,
    ROUND(AVG(discount) * 100, 2)  AS avg_discount_pct,
    ROUND(SUM(profit), 2)           AS total_profit
FROM transactions
GROUP BY product
HAVING AVG(discount) > 0.10
ORDER BY total_profit ASC;


-- ------------------------------------------------------------
-- 2. All loss-making orders (profit < 0)
--    Business question: What is the scale of loss-making transactions?
-- ------------------------------------------------------------
SELECT 
    order_id,
    customer_id,
    order_date,
    product,
    category,
    city,
    ROUND(sales, 2)    AS sales,
    ROUND(discount, 2) AS discount,
    ROUND(profit, 2)   AS profit
FROM transactions
WHERE profit < 0
ORDER BY profit ASC;


-- ------------------------------------------------------------
-- 3. Discount impact on profit by category
--    Business question: Does discounting hurt some categories more than others?
-- ------------------------------------------------------------
SELECT 
    category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
    ROUND(SUM(profit), 2)          AS total_profit,
    ROUND(SUM(sales), 2)           AS total_sales,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM transactions
GROUP BY category
ORDER BY avg_discount_pct DESC;


-- ------------------------------------------------------------
-- 4. Revenue leakage summary: total loss from negative-profit orders
--    Business question: What is the total financial damage from loss orders?
-- ------------------------------------------------------------
SELECT 
    COUNT(*)                          AS total_loss_orders,
    ROUND(SUM(profit), 2)             AS total_loss_amount,
    ROUND(AVG(discount) * 100, 2)     AS avg_discount_on_loss_orders
FROM transactions
WHERE profit < 0;
