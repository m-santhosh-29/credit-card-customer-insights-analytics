USE credit_card_analytics;

CREATE OR REPLACE VIEW customer_all AS
SELECT
  Client_Num, Customer_Age, Gender, Dependent_Count, Education_Level,
  Marital_Status, state_cd, Zipcode, Car_Owner, House_Owner,
  Personal_loan, contact, Customer_Job, Income, Cust_Satisfaction_Score
FROM customer
UNION ALL
SELECT
  Client_Num, Customer_Age, Gender, Dependent_Count, Education_Level,
  Marital_Status, state_cd, Zipcode, Car_Owner, House_Owner,
  Personal_loan, contact, Customer_Job, Income, Cust_Satisfaction_Score
FROM cust_add;

CREATE OR REPLACE VIEW credit_card_all AS
SELECT
  Client_Num, Card_Category, Annual_Fees, Activation_30_Days,
  Customer_Acq_Cost, Week_Start_Date, Week_Num, Qtr, current_year,
  Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt,
  Total_Trans_Vol AS transaction_count,
  Avg_Utilization_Ratio, `Use Chip` AS use_chip, `Exp Type` AS exp_type,
  Interest_Earned, Delinquent_Acc
FROM credit_card
UNION ALL
SELECT
  Client_Num, Card_Category, Annual_Fees, Activation_30_Days,
  Customer_Acq_Cost, Week_Start_Date, Week_Num, Qtr, current_year,
  Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt,
  Total_Trans_Ct AS transaction_count,
  Avg_Utilization_Ratio, `Use Chip` AS use_chip, `Exp Type` AS exp_type,
  Interest_Earned, Delinquent_Acc
FROM cc_add;


-- Verify combined totals. Based on uploaded files, each should be 10,293 rows.
SELECT 'customer_all' AS view_name, COUNT(*) AS row_count FROM customer_all
UNION ALL
SELECT 'credit_card_all', COUNT(*) FROM credit_card_all;

-- Check whether customer/card records match by Client_Num
SELECT
  COUNT(*) AS matched_customers
FROM customer_all c
INNER JOIN credit_card_all cc
  ON c.Client_Num = cc.Client_Num;
  
-- Find customer records without a card record (expected zero if all IDs match)
SELECT c.Client_Num
FROM customer_all c
LEFT JOIN credit_card_all cc ON c.Client_Num = cc.Client_Num
WHERE cc.Client_Num IS NULL;

-- Find card records without a customer profile (expected zero if all IDs match)
SELECT cc.Client_Num
FROM credit_card_all cc
LEFT JOIN customer_all c ON c.Client_Num = cc.Client_Num
WHERE c.Client_Num IS NULL;





