-- SELECT cust_id,
--        cust_first_name,
--        cust_year_of_birth,
--        EXTRACT(YEAR FROM SYSDATE) - cust_year_of_birth AS age
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_year_of_birth
-- FROM sh.customers
-- WHERE cust_year_of_birth BETWEEN 1980 AND 1990;

-- SELECT cust_id,
--        cust_first_name,
--        TO_CHAR(TO_DATE(cust_year_of_birth, 'YYYY'), 'Month YYYY') AS formatted_dob
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_income_level,
--        TO_NUMBER(REGEXP_SUBSTR(cust_income_level, '\d+')) AS income_lower_limit
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_year_of_birth,
--        TO_CHAR(FLOOR(cust_year_of_birth / 10) * 10) || 's' AS birth_decade
-- FROM sh.customers;

-- SELECT 
--   FLOOR((EXTRACT(YEAR FROM SYSDATE) - cust_year_of_birth)/10)*10 AS age_bracket,
--   COUNT(*) AS num_customers
-- FROM sh.customers
-- GROUP BY FLOOR((EXTRACT(YEAR FROM SYSDATE) - cust_year_of_birth)/10)*10
-- ORDER BY age_bracket;

-- SELECT UPPER(country_id) AS country_id_upper,
--        LOWER(cust_state_province) AS state_lower,
--        cust_first_name
-- FROM sh.customers;

-- SELECT cust_id,
--        cust_first_name,
--        cust_credit_limit,
--        cust_year_of_birth,
--        TO_CHAR(FLOOR(cust_year_of_birth/10)*10) || 's' AS birth_decade
-- FROM sh.customers c
-- WHERE cust_credit_limit >
--       (SELECT AVG(c2.cust_credit_limit)
--        FROM sh.customers c2
--        WHERE FLOOR(c2.cust_year_of_birth/10) = FLOOR(c.cust_year_of_birth/10));

-- SELECT cust_id,
--        cust_first_name,
--        TO_CHAR(cust_credit_limit, '$999,999.00') AS credit_limit_formatted
-- FROM sh.customers;

SELECT cust_id,
       cust_first_name,
       NVL(cust_credit_limit,
           (SELECT AVG(cust_credit_limit) FROM sh.customers)
       ) AS adjusted_credit_limit
FROM sh.customers;
