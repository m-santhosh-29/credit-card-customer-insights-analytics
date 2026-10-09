USE credit_card_analytics;

Q1. How many customers are in the full dataset?
SELECT COUNT(*) AS total_customers FROM customer_all;

-- Q2. How many customers are there by gender?
SELECT Gender, COUNT(*) AS customers
FROM customer_all
GROUP BY Gender
ORDER BY customers DESC;

-- Q3. What is the average customer age?
SELECT ROUND(AVG(CAST(NULLIF(Customer_Age, '') AS DECIMAL(10,2))), 1) AS average_age
FROM customer_all;

-- Q4. Which education levels are most common?
SELECT Education_Level, COUNT(*) AS customers
FROM customer_all
GROUP BY Education_Level
ORDER BY customers DESC;

-- Q5. How many customers are in each job category?
SELECT Customer_Job, COUNT(*) AS customers
FROM customer_all
GROUP BY Customer_Job
ORDER BY customers DESC;

-- Q6. What is the average income by job?
SELECT Customer_Job,
       ROUND(AVG(CAST(NULLIF(Income, '') AS DECIMAL(15,2))), 2) AS avg_income
FROM customer_all
GROUP BY Customer_Job
ORDER BY avg_income DESC;

-- Q7. What card categories do customers have?
SELECT Card_Category, COUNT(*) AS card_records
FROM credit_card_all
GROUP BY Card_Category
ORDER BY card_records DESC;

-- Q8. What is the total transaction amount by card category?
SELECT Card_Category,
       SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS total_transaction_amount
FROM credit_card_all
GROUP BY Card_Category
ORDER BY total_transaction_amount DESC;

-- Q9. What are total interest earned and average interest earned?
SELECT
  ROUND(SUM(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2))), 2) AS total_interest_earned,
  ROUND(AVG(CAST(NULLIF(Interest_Earned, '') AS DECIMAL(15,2))), 2) AS average_interest_earned
FROM credit_card_all;

-- Q10. How many accounts are delinquent?
SELECT Delinquent_Acc, COUNT(*) AS accounts
FROM credit_card_all
GROUP BY Delinquent_Acc
ORDER BY accounts DESC;

-- Q11. What is the average utilization ratio by card category?
SELECT Card_Category,
       ROUND(AVG(CAST(NULLIF(Avg_Utilization_Ratio, '') AS DECIMAL(10,4))), 3) AS avg_utilization
FROM credit_card_all
GROUP BY Card_Category
ORDER BY avg_utilization DESC;

-- Q12. What are the most common expense types?
SELECT exp_type, COUNT(*) AS records,
       SUM(CAST(NULLIF(Total_Trans_Amt, '') AS DECIMAL(15,2))) AS transaction_amount
FROM credit_card_all
GROUP BY exp_type
ORDER BY transaction_amount DESC;

