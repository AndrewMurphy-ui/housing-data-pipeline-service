
---

# 🏡 House Sales Analysis (1975–2024)

![image](https://github.com/user-attachments/assets/7cdc5fde-a1ab-42c5-8b27-f147985be2b2)


# 🏡 U.S. House Price Growth Analysis (1975–2024)
This project presents a comprehensive analysis of house price growth trends across U.S. states over 49 years (from Q1 1975 to Q1 2024). Historical housing index data was extracted, cleaned, and analyzed using a PostgreSQL database (House_db) to identify long-term appreciation trends and regional performance patterns. The primary focus is on Montana, which has demonstrated exceptional growth, alongside comparative insights from other high-performing states like Utah, Washington, and Oregan.

# 🛠️ Tools & Technologies
Database: PostgreSQL (House_db)

Language: SQL (data extraction & transformation)

Visualization: Power BI / Matplotlib (optional for visuals)

Metrics: Calculated percentage growth, total index growth, and quarterly growth rates

# 📊 Key Metrics for Montana
Metric	Value
Total Index Growth	492.41
Percentage Growth	260.15%
Average Quarterly Growth	0.64

Total Index Growth measures the change in Montana’s housing price index from 1975 to 2024.

Percentage Growth captures the overall proportional increase in house prices over the 49-year span.

Quarterly Growth reflects the average increase in index points per quarter.

# 📌 Key Insights
🔝 Top States by Total Growth (1975–2024)
Based on total index growth, the top four states are:

Montana

Utah

Washington

Oregon

Montana ranks #1 in total index growth, highlighting its remarkable long-term appreciation in property values. This trend may reflect a combination of factors including increased migration, changing lifestyle preferences, and economic development in the Mountain West region.

# 🔍 Additional Observations
Steady Growth Pattern: Montana’s housing market shows consistent quarterly increases with relatively low volatility, indicating stable demand over time.

Post-2000 Acceleration: A significant portion of the growth occurred after the year 2000, suggesting increased regional attractiveness or demographic shifts.

Comparison to National Trends: While the U.S. average also shows steady growth, Montana’s growth rate outpaces national averages and stands out among all 50 states.

# 📦 Potential Use Cases
Real Estate Investment Analysis

Policy Research on Housing Affordability

Regional Economic Trend Studies

Forecasting Models for Housing Markets
### 📉 Historical Trends
- The **average seasonally adjusted index (`index_sa`)** illustrates steady house price growth with a sharp increase post-2000.
- A dip around the early 1990s suggests possible market corrections or economic shifts.

## 🗺️ Visualizations

- **Bar Charts** for percentage and total growth
- **Map** of top-performing states
- **Quarterly Growth Rankings**
- **Line Chart** of indexed price trends over time

## 🛠️ Tools & Technologies

| Tool         | Purpose                          |
|--------------|----------------------------------|
| PostgreSQL   | Data storage and querying (`House_db`) |
| SQL          | Data transformation and calculation |
| Power BI     | Data visualization and dashboarding |
| GitHub       | Version control and collaboration |

## 🧾 Data Overview
- **Database Name:** `House_db`
- **Frequency:** Quarterly
- **Index Used:** `index_sa` (Seasonally Adjusted)
- **Time Period:** 1975 to 2024
- **Data Source:** [gov.ie housing dataset ](https://www.gov.ie)

## 📁 Project Structure
```bash
├── sql/
│   └── house_growth_analysis.sql
├── visuals/
│   └── dashboard.png
├── README.md
```

## 🚀 How to Use

1. **Clone this repository**  
   `git clone https://github.com/your-username/house-sales-analysis.git`

2. **Import the SQL dataset** into PostgreSQL as `House_db`.

3. **Run analysis queries** from `sql/house_growth_analysis.sql`.

4. **Open the Power BI dashboard** to explore visualizations.

5. **Adjust filters by state, year, or index type** to explore trends.

## 🎯 Key Learning

This project highlights how combining **SQL querying in PostgreSQL** with **Power BI dashboards** enables deep, visually-driven insights into long-term trends in the U.S. housing market.

---


