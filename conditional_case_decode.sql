-- SELECT cust_id,
--        cust_first_name,
--        cust_income_level,
--        CASE 
--          WHEN cust_credit_limit >= 100000 THEN 'Platinum'
--          WHEN cust_credit_limit BETWEEN 75000 AND 99999 THEN 'Gold'
--          WHEN cust_credit_limit BETWEEN 50000 AND 74999 THEN 'Silver'
--          ELSE 'Bronze'
--        END AS income_tier
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_credit_limit,
--        CASE 
--          WHEN cust_credit_limit > 80000 THEN 'High'
--          WHEN cust_credit_limit BETWEEN 40000 AND 80000 THEN 'Medium'
--          ELSE 'Low'
--        END AS income_category
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        NVL(cust_income_level, 'Unknown') AS income_level
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_credit_limit,
--        CASE 
--          WHEN cust_credit_limit > (SELECT AVG(cust_credit_limit) FROM sh.customers)
--          THEN 'Above Average'
--          ELSE 'Below Average'
--        END AS credit_status
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        DECODE(cust_marital_status,
--               'S', 'Single',
--               'M', 'Married',
--               'D', 'Divorced',
--               'Unknown') AS marital_status
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_year_of_birth,
--        CASE 
--          WHEN EXTRACT(YEAR FROM SYSDATE) - cust_year_of_birth <= 30 THEN '≤30'
--          WHEN EXTRACT(YEAR FROM SYSDATE) - cust_year_of_birth BETWEEN 31 AND 50 THEN '31–50'
--          ELSE '>50'
--        END AS age_group
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_year_of_birth,
--        CASE 
--          WHEN cust_year_of_birth < 1980 THEN 'Old Credit Holder'
--          ELSE 'New Credit Holder'
--        END AS credit_holder_type
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_credit_limit,
--        cust_income_level,
--        CASE 
--          WHEN cust_credit_limit > 50000 AND cust_income_level = 'E' THEN 'Premium'
--          ELSE 'Standard'
--        END AS loyalty_tag
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_credit_limit,
--        CASE 
--          WHEN cust_credit_limit >= 100000 THEN 'A'
--          WHEN cust_credit_limit BETWEEN 80000 AND 99999 THEN 'B'
--          WHEN cust_credit_limit BETWEEN 60000 AND 79999 THEN 'C'
--          WHEN cust_credit_limit BETWEEN 40000 AND 59999 THEN 'D'
--          WHEN cust_credit_limit BETWEEN 20000 AND 39999 THEN 'E'
--          ELSE 'F'
--        END AS credit_grade
-- FROM sh.customers;

SELECT COUNTRY_ID,
       CUST_STATE_PROVINCE,
       COUNT(CASE 
               WHEN CUST_CREDIT_LIMIT > 50000 
                    AND CUST_INCOME_LEVEL = 'E' 
               THEN 1 
             END) AS PREMIUM_CUSTOMERS
FROM SH.CUSTOMERS
GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE
ORDER BY PREMIUM_CUSTOMERS DESC;

