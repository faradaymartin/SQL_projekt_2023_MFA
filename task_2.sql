
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?



SELECT price_c_code, price_c_name, round (avg(cp_price_value),2) , payroll_year 
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE price_c_name = 'banány žluté'
GROUP BY payroll_year 
ORDER BY payroll_year 
;

SELECT price_c_code, price_c_name, cp_price_value  , payroll_year 
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
GROUP BY price_c_code 
ORDER BY payroll_year 
;

SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
GROUP BY payroll_year, price_c_name
ORDER BY payroll_year
;

SELECT t1.payroll_year, t1.price_c_name, t1.average_price, 
    ((t1.average_price - t2.average_price) / t2.average_price) * 100 AS percentage_difference
FROM (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t1
JOIN (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t2 ON t1.price_c_name = t2.price_c_name AND t1.payroll_year = t2.payroll_year + 1
ORDER BY t1.payroll_year, t1.price_c_name, t1.average_price DESC 
;
SELECT t1.payroll_year, t1.price_c_name, t1.average_price, 
    ((t1.average_price - t2.average_price) / t2.average_price) * 100 AS percentage_difference
FROM (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t1
JOIN (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t2 ON t1.price_c_name = t2.price_c_name AND t1.payroll_year = t2.payroll_year + 1
GROUP BY t1.price_c_name
HAVING COUNT(*) > 1
ORDER BY percentage_difference ASC
;

SELECT t1.payroll_year, t1.price_c_name, t1.average_price, 
    round ((((t1.average_price - t2.average_price) / t2.average_price) * 100),2) AS percentage_difference
FROM (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t1
JOIN (
    SELECT payroll_year, price_c_name, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year, price_c_name
) t2 ON t1.price_c_name = t2.price_c_name AND t1.payroll_year = t2.payroll_year + 1
ORDER BY percentage_difference, price_c_name ASC
LIMIT 1
;
