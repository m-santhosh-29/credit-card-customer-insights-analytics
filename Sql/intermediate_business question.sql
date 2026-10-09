USE credit_card_analytics;

-- Q1. Join customer demographics with credit-card performance.
SELECT c.Client_Num, c.Customer_Age, c.Gender, c.Customer_Job, c.Income,
       cc.Card_Category, cc.Total_Trans_Amt, cc.transaction_count,
       cc.Interest_Earned, cc.Avg_Utilization_Ratio
FROM customer_all c
INNER JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
LIMIT 100;

-- Q2. Which jobs generate the highest transaction amount?
SELECT c.Customer_Job,
       COUNT(*) AS customers,
       SUM(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_transaction_amount,
       ROUND(AVG(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))), 2) AS avg_amount_per_record
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job
ORDER BY total_transaction_amount DESC;


-- Q3. Compare average interest earned by income band.
SELECT
  CASE
    WHEN CAST(NULLIF(c.Income, '') AS DECIMAL(15,2)) < 30000 THEN 'Under 30K'
    WHEN CAST(NULLIF(c.Income, '') AS DECIMAL(15,2)) < 60000 THEN '30K-59,999'
    WHEN CAST(NULLIF(c.Income, '') AS DECIMAL(15,2)) < 100000 THEN '60K-99,999'
    ELSE '100K+'
  END AS income_band,
  COUNT(*) AS customers,
  ROUND(AVG(CAST(NULLIF(cc.Interest_Earned, '') AS DECIMAL(15,2))), 2) AS avg_interest
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY income_band
ORDER BY avg_interest DESC;


-- Q4. Which states have the highest transaction amount?
SELECT c.state_cd,
       COUNT(*) AS customers,
       SUM(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_transaction_amount
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY c.state_cd
ORDER BY total_transaction_amount DESC
LIMIT 10;

-- Q5. Are personal-loan customers more or less active? (Descriptive comparison, not causation.)
SELECT c.Personal_loan,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))), 2) AS avg_transaction_amount,
       ROUND(AVG(CAST(NULLIF(cc.transaction_count, '') AS DECIMAL(15,2))), 2) AS avg_transaction_count,
       ROUND(AVG(CAST(NULLIF(cc.Interest_Earned, '') AS DECIMAL(15,2))), 2) AS avg_interest
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Personal_loan;


-- Q6. Compare satisfaction score and average interest.
SELECT c.Cust_Satisfaction_Score,
       COUNT(*) AS customers,
       ROUND(AVG(CAST(NULLIF(cc.Interest_Earned, '') AS DECIMAL(15,2))), 2) AS avg_interest,
       ROUND(AVG(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))), 2) AS avg_transaction_amount
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Cust_Satisfaction_Score
ORDER BY c.Cust_Satisfaction_Score;


-- Q7. Which card categories have high delinquency rates?
SELECT Card_Category,
       COUNT(*) AS total_accounts,
       SUM(CASE WHEN CAST(NULLIF(Delinquent_Acc, '') AS UNSIGNED) = 1 THEN 1 ELSE 0 END) AS delinquent_accounts,
       ROUND(100.0 * SUM(CASE WHEN CAST(NULLIF(Delinquent_Acc, '') AS UNSIGNED) = 1 THEN 1 ELSE 0 END)
             / NULLIF(COUNT(*), 0), 2) AS delinquency_pct
FROM credit_card_all
GROUP BY Card_Category
ORDER BY delinquency_pct DESC;

-- Q8. Which card categories recover the highest interest relative to transaction amount?
SELECT Card_Category,
       ROUND(SUM(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2))), 2) AS total_interest,
       ROUND(SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))), 2) AS total_transaction_amount,
       ROUND(100.0 * SUM(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2)))
             / NULLIF(SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))), 0), 2) AS interest_to_transaction_pct
FROM credit_card_all
GROUP BY Card_Category
ORDER BY interest_to_transaction_pct DESC;

-- Q9. Show customers whose utilization is above the dataset average.
SELECT c.Client_Num, c.Customer_Age, c.Customer_Job, cc.Card_Category,
       cc.Avg_Utilization_Ratio, cc.Credit_Limit
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
WHERE CAST(NULLIF(cc.Avg_Utilization_Ratio, '') AS DECIMAL(10,4)) >
      (SELECT AVG(CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4))) FROM credit_card_all)
ORDER BY CAST(NULLIF(cc.Avg_Utilization_Ratio, '') AS DECIMAL(10,4)) DESC
LIMIT 100;

-- Q10. Which customer jobs have average transaction amount above the overall average?
SELECT c.Customer_Job,
       ROUND(AVG(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))), 2) AS avg_transaction_amount
FROM customer_all c
JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job
HAVING AVG(CAST(NULLIF(cc.Total_Trans_Amt, '') AS DECIMAL(15,2))) >
       (SELECT AVG(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) FROM credit_card_all)
ORDER BY avg_transaction_amount DESC;