USE credit_card_analytics;

-- Q1. Rank card categories by total transaction amount.
WITH category_summary AS (
  SELECT Card_Category,
         SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_amount
  FROM credit_card_all
  GROUP BY Card_Category
)
SELECT Card_Category, total_amount,
       DENSE_RANK() OVER (ORDER BY total_amount DESC) AS category_rank
FROM category_summary;

-- Q2. Top 3 customers by transaction amount within each card category.
WITH ranked_customers AS (
  SELECT c.Client_Num, c.Customer_Job, cc.Card_Category,
         CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2)) AS transaction_amount,
         ROW_NUMBER() OVER (
           PARTITION BY cc.Card_Category
           ORDER BY CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2)) DESC
         ) AS row_num
  FROM customer_all c
  JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
)
SELECT *
FROM ranked_customers
WHERE row_num <= 3
ORDER BY Card_Category, row_num;

-- Q3. Find customers in the top 10% of transaction amount using NTILE.
WITH customer_tiles AS (
  SELECT Client_Num,
         CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2)) AS transaction_amount,
         NTILE(10) OVER (
           ORDER BY CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2)) DESC
         ) AS spend_decile
  FROM credit_card_all
)
SELECT *
FROM customer_tiles
WHERE spend_decile = 1
ORDER BY transaction_amount DESC;

-- Q4. Calculate each expense type's share of total transaction amount.
WITH expense_totals AS (
  SELECT exp_type,
         SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS amount
  FROM credit_card_all
  GROUP BY exp_type
)
SELECT exp_type, amount,
       ROUND(100.0 * amount / NULLIF(SUM(amount) OVER (), 0), 2) AS pct_of_total
FROM expense_totals
ORDER BY pct_of_total DESC;

-- Q5. Segment customers based on utilization and delinquency.


-- Q6. Identify unusually high transaction amounts using mean + 2 standard deviations.
WITH stats AS (
  SELECT AVG(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS avg_amount,
         STDDEV_POP(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS sd_amount
  FROM credit_card_all
)
SELECT cc.Client_Num, cc.Card_Category, cc.Total_Trans_Amt,
       s.avg_amount, s.sd_amount
FROM credit_card_all cc
CROSS JOIN stats s
WHERE CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2)) > s.avg_amount + 2 * s.sd_amount
ORDER BY CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2)) DESC;

-- Q7. Compare card categories with a CTE and calculate average metrics.
WITH card_metrics AS (
  SELECT Card_Category,
         COUNT(*) AS accounts,
         AVG(CAST(NULLIF(Credit_Limit, '') AS DECIMAL(15,2))) AS avg_credit_limit,
         AVG(CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4))) AS avg_utilization,
         AVG(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2))) AS avg_interest,
         AVG(CAST(NULLIF(transaction_count, '') AS DECIMAL(15,2))) AS avg_transaction_count
  FROM credit_card_all
  GROUP BY Card_Category
)
SELECT Card_Category, accounts,
       ROUND(avg_credit_limit, 2) AS avg_credit_limit,
       ROUND(avg_utilization, 3) AS avg_utilization,
       ROUND(avg_interest, 2) AS avg_interest,
       ROUND(avg_transaction_count, 2) AS avg_transaction_count
FROM card_metrics
ORDER BY avg_interest DESC;

-- Q8. Find customer profiles whose income is above their job-category average.
WITH job_income AS (
  SELECT Customer_Job,
         AVG(CAST(NULLIF(Income, '') AS DECIMAL(15,2))) AS job_avg_income
  FROM customer_all
  GROUP BY Customer_Job
)
SELECT c.Client_Num, c.Customer_Job, c.Income, ji.job_avg_income
FROM customer_all c
JOIN job_income ji ON c.Customer_Job = ji.Customer_Job
WHERE CAST(NULLIF(c.Income, '') AS DECIMAL(15,2)) > ji.job_avg_income
ORDER BY c.Customer_Job, CAST(NULLIF(c.Income, '') AS DECIMAL(15,2)) DESC;

-- Q9. Use LAG to compare weekly transaction amounts in the dataset.
-- This assumes Week_Start_Date is a date string in MM/DD/YYYY format.
WITH weekly AS (
  SELECT STR_TO_DATE(Week_Start_Date, '%m/%d/%Y') AS week_start,
         SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_amount
  FROM credit_card_all
  GROUP BY STR_TO_DATE(Week_Start_Date, '%m/%d/%Y')
),
with_previous AS (
  SELECT week_start, total_amount,
         LAG(total_amount) OVER (ORDER BY week_start) AS previous_week_amount
  FROM weekly
)
SELECT week_start, total_amount, previous_week_amount,
       ROUND(100.0 * (total_amount - previous_week_amount) /
             NULLIF(previous_week_amount, 0), 2) AS pct_change
FROM with_previous
ORDER BY week_start;

-- Q10. Create a reusable summary view for BI/dashboard reporting.
CREATE OR REPLACE VIEW card_category_kpi AS
SELECT Card_Category,
       COUNT(*) AS accounts,
       SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_transaction_amount,
       SUM(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2))) AS total_interest_earned,
       AVG(CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4))) AS avg_utilization,
       SUM(CASE WHEN CAST(NULLIF(Delinquent_Acc, '') AS UNSIGNED) = 1 THEN 1 ELSE 0 END) AS delinquent_accounts
FROM credit_card_all
GROUP BY Card_Category;

SELECT * FROM card_category_kpi ORDER BY total_transaction_amount DESC;
