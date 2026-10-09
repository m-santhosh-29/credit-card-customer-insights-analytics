USE credit_card_analytics;

-- Check customer field blanks
SELECT
  SUM(Customer_Age IS NULL OR TRIM(CAST(Customer_Age AS CHAR)) = '') AS missing_age,
  SUM(Gender IS NULL OR TRIM(Gender) = '') AS missing_gender,
  SUM(Income IS NULL OR TRIM(CAST(Income AS CHAR)) = '') AS missing_income,
  SUM(Education_Level IS NULL OR TRIM(Education_Level) = '') AS missing_education
FROM customer_all;

-- Check invalid age values
SELECT Client_Num, Customer_Age
FROM customer_all
WHERE CAST(NULLIF(Customer_Age, '') AS UNSIGNED) < 18
   OR CAST(NULLIF(Customer_Age, '') AS UNSIGNED) > 100;

-- Check suspicious ratios outside 0-1 (expected utilization ratio usually 0 to 1)
SELECT Client_Num, Avg_Utilization_Ratio
FROM credit_card_all
WHERE CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4)) < 0
   OR CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4)) > 1;

-- Check negative numeric values that may need investigation
SELECT Client_Num, Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Interest_Earned
FROM credit_card_all
WHERE CAST(NULLIF(Credit_Limit, '') AS DECIMAL(15,2)) < 0
   OR CAST(NULLIF(Total_Revolving_Bal, '') AS DECIMAL(15,2)) < 0
   OR CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2)) < 0
   OR CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2)) < 0;

-- Inspect date values that cannot be parsed
SELECT DISTINCT Week_Start_Date
FROM credit_card_all
WHERE STR_TO_DATE(Week_Start_Date, '%m/%d/%Y') IS NULL
  AND TRIM(COALESCE(Week_Start_Date, '')) <> '';

-- Find exact duplicate customer records (excluding Client_Num not useful if unique keys are expected)
SELECT Client_Num, COUNT(*) AS copies
FROM customer_all
GROUP BY Client_Num
HAVING COUNT(*) > 1;

-- Find exact duplicate card rows by key
SELECT Client_Num, COUNT(*) AS copies
FROM credit_card_all
GROUP BY Client_Num
HAVING COUNT(*) > 1;
