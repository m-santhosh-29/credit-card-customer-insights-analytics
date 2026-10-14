# 💳 Credit Card Customer Insights & Analytics

> An end-to-end data analytics project that uses **SQL**, **Python**, and **Power BI** to uncover spending patterns, customer behavior, card performance, revenue trends, credit utilization, and delinquency risk, and turns them into an interactive dashboard for data-driven decisions.

![SQL](https://img.shields.io/badge/SQL-Analysis-blue?logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-EDA-3776AB?logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Table of Contents
- [Project Overview](#-project-overview)
- [Business Problem](#-business-problem)
- [Objectives](#-objectives)
- [Dataset](#-dataset)
- [Tech Stack](#-tech-stack)
- [Repository Structure](#-repository-structure)
- [Methodology](#-methodology)
- [Key KPIs](#-key-kpis)
- [Dashboard Preview](#-dashboard-preview)
- [Key Insights](#-key-insights)
- [Business Recommendations](#-business-recommendations)
- [How to Run](#-how-to-run)
- [Future Improvements](#-future-improvements)
- [Author](#-author)

---

## 🔎 Project Overview

Credit card issuers sit on large volumes of customer and transaction data, but raw numbers alone don't drive decisions. This project analyzes credit card customer and transaction data to understand **who the customers are, how they spend, which cards perform best, where revenue comes from, and where risk lies**.

The workflow covers data exploration and cleaning, SQL-based business analysis, Python exploratory analysis, and a Power BI dashboard that presents the findings to stakeholders.

## 🎯 Business Problem

A credit card business wants clear answers to questions such as:

- Which customer segments generate the most revenue and spend?
- Which card categories and transaction channels perform best?
- How is credit utilization distributed, and who is at risk of over-utilization?
- What does delinquency look like, and which segments drive it?
- How do spending and revenue trend over time?

## ✅ Objectives

- Identify **spending patterns** across demographics, card types, and merchant/expense categories.
- Analyze **customer behavior** and segment customers by value and activity.
- Measure **card performance** and **revenue metrics** (interest, fees, interchange, etc.).
- Evaluate **credit utilization** and flag high-risk accounts.
- Track **delinquency** and its relationship to customer attributes.
- Build an **interactive Power BI dashboard** for self-serve insights.

## 📂 Dataset

The dataset consists of credit card **customer** and **transaction** data (see the `Data Set/` folder).

| Table | Description |
|-------|-------------|
| Customer data | Demographics, income, card category, credit limit, utilization, and related attributes |
| Transaction data | Transaction amount, date, channel, expense type, and related attributes |

> 📝 *Update this table with your exact file names, row counts, and column lists.*

## 🛠 Tech Stack

| Tool | Purpose |
|------|---------|
| **SQL** | Data cleaning, joins, aggregation, KPI and business-question queries |
| **Python** (Pandas, NumPy, Matplotlib/Seaborn) | Exploratory data analysis and visualization |
| **Power BI** | Interactive dashboard, DAX measures, storytelling |
| **GitHub** | Version control and project showcase |

## 🗂 Repository Structure

```
credit-card-customer-insights-analytics/
│
├── Dashboards/         # Power BI dashboard (.pbix) and dashboard screenshots
├── Data Set/           # Raw customer and transaction data files
├── Sql/                # SQL scripts for cleaning, analysis, and KPI queries
├── python analysis/    # Python notebooks/scripts for EDA
└── README.md           # Project documentation
```

## ⚙️ Methodology

1. **Data Understanding**: reviewed the customer and transaction tables, data types, and relationships.
2. **Data Cleaning**: handled missing values, duplicates, inconsistent formats, and outliers.
3. **SQL Analysis**: wrote queries to answer business questions and compute KPIs (revenue, spend, utilization, delinquency).
4. **Python EDA**: explored distributions, correlations, and trends with visualizations.
5. **Dashboarding**: modeled the data in Power BI, built DAX measures, and designed an interactive multi-page report.
6. **Insight Generation**: translated findings into actionable business recommendations.

## 📊 Key KPIs

- 💰 **Total Revenue**
- 🛒 **Total Transaction Amount & Count**
- 👥 **Total Customers / Active Customers**
- 💳 **Average Credit Utilization Ratio**
- ⚠️ **Delinquency Rate**
- 📈 **Revenue / Spend by Card Category, Channel, and Time Period**

> 📝 *Adjust this list to match the KPIs in your dashboard.*

## 🖥 Dashboard Preview

The Power BI report has four interactive pages, filterable by **week, quarter, card category, gender, and income group**.

### 1️⃣ Revenue Dashboard
Tracks total revenue, interest earned, transaction amount and volume, along with revenue by card category, expenditure type, education level, and customer job. Also covers quarterly trends, week-over-week revenue change, chip usage, and customer acquisition cost.

![Revenue Dashboard](Dashboards/revenue_dashboard.png)

### 2️⃣ Customer Report
Analyzes customer demographics and behavior: revenue by age group, gender, top 5 states, income group, marital status, education, and dependents, plus the customer satisfaction score.

![Customer Report](Dashboards/customer_report.png)

### 3️⃣ Income Statement Report
Breaks down total income and clients by house ownership, personal loan, car ownership, marital status, education, job, dependents, and age group.

![Income Report](Dashboards/income_report.png)

### 4️⃣ Details
Covers weekly transaction trends, transactions by channel (swipe / chip / online) and customer job, week-over-week transaction change, 30-day activation rate, and delinquent account percentage.

![Details](Dashboards/details.png)

## 💡 Key Insights

> 📝 *Replace these with your real findings. Examples of the format that works well:*

- 🔹 **Top customer segment** (age/income group) contributes **X%** of total revenue.
- 🔹 **Card category** *(e.g., Blue/Silver/Gold/Platinum)* drives the highest transaction volume.
- 🔹 **Spending peaks** in *(month/quarter)*, suggesting seasonal campaign opportunities.
- 🔹 Customers with **utilization above X%** show a noticeably higher delinquency rate.
- 🔹 **Channel** *(swipe/online/chip)* accounts for **X%** of transactions.

## 🚀 Business Recommendations

- Target high-value segments with premium card upgrades and loyalty offers.
- Launch seasonal promotions aligned with peak spending periods.
- Monitor high-utilization accounts early to reduce delinquency risk.
- Promote the best-performing channels and re-engage low-activity customers.

## ▶️ How to Run

```bash
# 1. Clone the repository
git clone https://github.com/m-santhosh-29/credit-card-customer-insights-analytics.git
cd credit-card-customer-insights-analytics
```

1. **SQL**: load the files from `Data Set/` into your database (MySQL / PostgreSQL / SQL Server) and run the scripts in `Sql/`.
2. **Python**: install dependencies and open the notebook in `python analysis/`:
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   jupyter notebook
   ```
3. **Power BI**: open the `.pbix` file in `Dashboards/` using **Power BI Desktop** and refresh the data source path if needed.

## 🔮 Future Improvements

- Add predictive models for **delinquency / churn** using machine learning.
- Automate data refresh with a live database connection.
- Add customer segmentation (RFM / clustering).
- Publish the dashboard to Power BI Service for sharing.

## 👤 Author

**Santhosh M**
- GitHub: [@m-santhosh-29](https://github.com/m-santhosh-29)
- LinkedIn: [Santhosh M](https://www.linkedin.com/in/santhosh-m-32a61b419)

⭐ *If you found this project useful, please consider giving it a star!*
