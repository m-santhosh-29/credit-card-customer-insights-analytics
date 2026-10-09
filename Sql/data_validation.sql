USE credit_card_analytics;
-- Check row counts
SELECT 'customer' AS table_name, COUNT(*) AS row_count FROM customer
UNION ALL
SELECT 'cust_add', COUNT(*) FROM cust_add
UNION ALL
SELECT 'credit_card', COUNT(*) FROM credit_card
UNION ALL
SELECT 'cc_add', COUNT(*) FROM cc_add;

-- Check whether Client_Num is duplicated in each table
SELECT 'customer' AS table_name, COUNT(*) AS duplicate_client_nums
FROM (SELECT Client_Num FROM customer GROUP BY Client_Num HAVING COUNT(*) > 1) d
UNION ALL
SELECT 'cust_add', COUNT(*)
FROM (SELECT Client_Num FROM cust_add GROUP BY Client_Num HAVING COUNT(*) > 1) d
UNION ALL
SELECT 'credit_card', COUNT(*)
FROM (SELECT Client_Num FROM credit_card GROUP BY Client_Num HAVING COUNT(*) > 1) d
UNION ALL
SELECT 'cc_add', COUNT(*)
FROM (SELECT Client_Num FROM cc_add GROUP BY Client_Num HAVING COUNT(*) > 1) d;

-- Check blank/NULL customer keys
SELECT 'customer' AS table_name, COUNT(*) AS missing_client_num
FROM customer WHERE Client_Num IS NULL OR TRIM(CAST(Client_Num AS CHAR)) = ''
UNION ALL
SELECT 'cust_add', COUNT(*) FROM cust_add
WHERE Client_Num IS NULL OR TRIM(CAST(Client_Num AS CHAR)) = ''
UNION ALL
SELECT 'credit_card', COUNT(*) FROM credit_card
WHERE Client_Num IS NULL OR TRIM(CAST(Client_Num AS CHAR)) = ''
UNION ALL
SELECT 'cc_add', COUNT(*) FROM cc_add
WHERE Client_Num IS NULL OR TRIM(CAST(Client_Num AS CHAR)) = '';

-- Inspect column definitions after import
DESCRIBE customer;
DESCRIBE cust_add;
DESCRIBE credit_card;
DESCRIBE cc_add;


-- Inspect samples
SELECT * FROM customer LIMIT 10;
SELECT * FROM cust_add LIMIT 10;
SELECT * FROM credit_card LIMIT 10;
SELECT * FROM cc_add LIMIT 10;
