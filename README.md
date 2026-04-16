# Revenue Leakage & Customer Retention Analysis

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

A end-to-end data analytics project analyzing revenue leakage, discount impact, and customer retention patterns across product categories and cities using **MySQL** for analysis and **Power BI** for visualization.

---

## Problem Statement

The business was experiencing revenue leakage due to aggressive discounting, but had no visibility into:
- Which products and categories were loss-making
- Whether high discounts actually drove more sales
- Which customer segments were most valuable long-term
- How customer retention varied across cohorts

---

## Dashboard Preview

| Executive Overview | Revenue Leakage |
|---|---|
| ![Executive Overview](assets/executive_overview.png) | ![Revenue Leakage](assets/revenue_leakage.png) |

> Built in Power BI — 2 pages, 8+ visuals, fully interactive with slicers for Category, City, and Date.

---

## Key Findings

| Metric | Value |
|---|---|
| Total Sales | ₹632.44M |
| Total Profit | ₹127.47M |
| Profit Margin | 20.16% |
| Avg Discount | 24.92% |
| Loss Orders | 6K (24.70% of all orders) |
| Total Revenue Leakage | -₹15.25M |

### Insights
1. **Over-discounting (>30%)** is the primary driver of ₹15M revenue loss
2. **Fashion leads** revenue contribution (₹214M) but all 3 categories have near-equal margins (~20%)
3. **Delhi, Chennai, Mumbai** contribute the most profit at ₹26M each
4. Revenue shows **seasonal peaks in Jan and Jul**, with dips in Feb and May
5. Certain SKUs have consistent negative profit margins — candidates for discontinuation

---

## Project Structure

```
revenue-leakage-analysis/
│
├── sql/
│   ├── schema/
│   │   └── create_tables.sql        # Table definitions (customers, transactions)
│   └── analysis/
│       ├── 01_revenue_leakage.sql   # Discount and loss detection queries
│       ├── 02_customer_retention.sql# Retention, CLV, cohort analysis
│       ├── 03_product_analysis.sql  # Top products, category performance
│       └── 04_profitability.sql     # Margin analysis, discount impact
│
├── assets/
│   ├── executive_overview.png       # Dashboard screenshot - page 1
│   └── revenue_leakage.png          # Dashboard screenshot - page 2
│
├── docs/
│   └── business_questions.md        # Business questions this project answers
│
└── README.md
```

---

## SQL Analysis Covered

| File | Analysis |
|---|---|
| `01_revenue_leakage.sql` | Loss-making orders, products with high discounts, leakage detection |
| `02_customer_retention.sql` | First/last purchase dates, repeat behaviour, CLV, cohort retention |
| `03_product_analysis.sql` | Top 10 products by sales, category-level performance |
| `04_profitability.sql` | Overall margin, customer stage value (new vs old), discount vs profit |

---

## How to Run

### Prerequisites
- MySQL 8.0+
- Power BI Desktop (for `.pbix` file, if shared)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/revenue-leakage-analysis.git
cd revenue-leakage-analysis

# 2. Set up the database
mysql -u root -p < sql/schema/create_tables.sql

# 3. Load your data (CSV import via MySQL Workbench or LOAD DATA INFILE)

# 4. Run analysis queries
mysql -u root -p cus_retention < sql/analysis/01_revenue_leakage.sql
```

> **Note:** The original dataset is not included for privacy. You can substitute any retail transactions dataset with the same schema.

---

## Tools & Skills Demonstrated

- **MySQL** — Aggregations, JOINs, Window Functions, CTEs, DATE functions
- **Power BI** — DAX measures, slicers, conditional formatting, multi-page dashboards
- **Business Analysis** — KPI design, revenue leakage identification, customer segmentation
- **Data Storytelling** — Insight extraction, actionable recommendations

---

## Recommendations Derived

1. Introduce **discount threshold alerts** (cap at 25%) to prevent over-discounting
2. **Fix or remove loss-making SKUs** — especially Watch and Camera with <20% margin
3. Focus promotions on **high-profit items** rather than blanket discounts
4. **Discontinue bottom 10% profit SKUs** to improve overall margin
5. Investigate fulfilment issues in cities with high loss order rates

---

## Author

**Raghav Sharma**  
Aspiring Data / Business Analyst  
[LinkedIn](https://linkedin.com/in/raghav-sharma-a76bb922a) • [GitHub](https://github.com/Raghav20-cyber)
