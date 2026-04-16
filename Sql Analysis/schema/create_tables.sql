-- ============================================================
-- Schema: Customer Retention & Revenue Leakage Analysis
-- Database: cus_retention
-- Author: Raghav Sharma
-- ============================================================

CREATE DATABASE IF NOT EXISTS cus_retention;
USE cus_retention;

-- ------------------------------------------------------------
-- Table: customers
-- Stores customer profile and segmentation data
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    join_date   DATE,
    segment     VARCHAR(50),
    city        VARCHAR(100)
);

-- ------------------------------------------------------------
-- Table: transactions
-- Stores order-level sales and profitability data
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS transactions (
    order_id    VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date  DATE,
    product     VARCHAR(255),
    category    VARCHAR(100),
    sales       DECIMAL(10, 2),
    quantity    INT,
    discount    DECIMAL(5, 2),
    profit      DECIMAL(10, 2),
    city        VARCHAR(100),

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
