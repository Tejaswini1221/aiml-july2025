
-- desc sh.CUSTOMERS

-- SELECT 
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS state_rank
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_STATE_PROVINCE,
--     CUST_CREDIT_LIMIT,
--     RANK() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT DESC) AS state_rank
-- FROM sh.customers;

-- SELECT *
-- FROM (
--     SELECT 
--         CUST_ID,
--         CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         DENSE_RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS rank_in_country
--     FROM sh.customers
-- )
-- WHERE rank_in_country <= 5;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     NTILE(4) OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS quartile
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS running_total
-- FROM sh.customers;

-- SELECT 
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_ID) AS cumulative_avg
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS prev_credit_limit
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     LEAD(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS next_credit_limit
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS diff_from_prev
-- FROM sh.customers;

-- SELECT 
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     FIRST_VALUE(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS first_credit_limit,
--     LAST_VALUE(CUST_CREDIT_LIMIT)  OVER (
--         PARTITION BY COUNTRY_ID 
--         ORDER BY CUST_CREDIT_LIMIT DESC
--         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
--     ) AS last_credit_limit
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     PERCENT_RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS pct_rank
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     CUME_DIST() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS percentile_position
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     MAX(CUST_CREDIT_LIMIT) OVER () - CUST_CREDIT_LIMIT AS diff_from_max
-- FROM sh.customers;

-- SELECT 
--     CUST_INCOME_LEVEL,
--     AVG(CUST_CREDIT_LIMIT) AS avg_credit_limit,
--     RANK() OVER (ORDER BY AVG(CUST_CREDIT_LIMIT) DESC) AS income_rank
-- FROM sh.customers
-- GROUP BY CUST_INCOME_LEVEL;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS avg_last_10
-- FROM sh.customers;


-- SELECT 
--     CUST_STATE_PROVINCE,
--     CUST_CITY,
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CITY) AS state_cum_total
-- FROM sh.customers;

-- SELECT *
-- FROM sh.customers
-- WHERE CUST_CREDIT_LIMIT = (
--     SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT)
--     FROM sh.customers
-- );


-- SELECT *
-- FROM (
--     SELECT 
--         CUST_ID,
--         CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--         CUST_STATE_PROVINCE,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT DESC) AS rn
--     FROM sh.customers
-- )
-- WHERE rn <= 3;


-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     CASE 
--         WHEN CUST_CREDIT_LIMIT > LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID)
--         THEN 'Increased'
--         ELSE 'Not Increased'
--     END AS credit_status
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
-- FROM sh.customers;

-- SELECT 
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     ROUND(
--         SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC)
--         / SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) * 100, 2
--     ) AS cumulative_percent
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) AS AGE,
--     RANK() OVER (ORDER BY (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) DESC) AS age_rank
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_STATE_PROVINCE,
--     (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) AS AGE,
--     (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)
--       - LAG(EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)
--         OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_ID) AS age_diff
-- FROM sh.customers;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS rank_val,
--     DENSE_RANK() OVER (ORDER BY CUST_CREDIT_LIMIT DESC) AS dense_rank_val
-- FROM sh.customers;

-- SELECT DISTINCT 
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID, CUST_STATE_PROVINCE) AS state_avg,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS country_avg
-- FROM sh.customers;

-- SELECT
--     COUNTRY_ID,
--     CUST_STATE_PROVINCE,
--     total_credit,
--     RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY total_credit DESC) AS state_rank
-- FROM (
--     SELECT
--         COUNTRY_ID,
--         CUST_STATE_PROVINCE,
--         SUM(CUST_CREDIT_LIMIT) AS total_credit
--     FROM sh.customers
--     GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE
-- ) state_totals
-- ORDER BY COUNTRY_ID, state_rank;

-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     CUST_INCOME_LEVEL
-- FROM sh.customers c
-- WHERE CUST_CREDIT_LIMIT > (
--     SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT)
--     FROM sh.customers
--     WHERE CUST_INCOME_LEVEL = c.CUST_INCOME_LEVEL
-- )
-- ORDER BY CUST_INCOME_LEVEL, CUST_CREDIT_LIMIT DESC;



-- SELECT *
-- FROM (
--     SELECT 
--         CUST_ID,
--         CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS top_rn,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT ASC) AS bottom_rn
--     FROM sh.customers
-- )
-- WHERE top_rn <= 3 OR bottom_rn <= 3;



-- SELECT 
--     COUNTRY_ID,
--     CUST_ID,
--     CUST_FIRST_NAME || ' ' || CUST_LAST_NAME AS CUST_NAME,
--     CUST_CREDIT_LIMIT,
--     SUM(CUST_CREDIT_LIMIT) OVER (
--         PARTITION BY COUNTRY_ID 
--         ORDER BY CUST_ID 
--         ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
--     ) AS rolling_sum_5
-- FROM sh.customers;


-- SELECT DISTINCT 
--     CUST_MARITAL_STATUS,
--     FIRST_VALUE(CUST_FIRST_NAME || ' ' || CUST_LAST_NAME)
--         OVER (PARTITION BY CUST_MARITAL_STATUS ORDER BY CUST_CREDIT_LIMIT DESC) AS richest_customer,
--     LAST_VALUE(CUST_FIRST_NAME || ' ' || CUST_LAST_NAME)
--         OVER (
--             PARTITION BY CUST_MARITAL_STATUS 
--             ORDER BY CUST_CREDIT_LIMIT DESC
--             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
--         ) AS poorest_customer
-- FROM sh.customers;

