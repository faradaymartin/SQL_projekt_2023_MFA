

SELECT*
FROM t_martin_faraday_project_sql_primary_final tmfpspf ;

SELECT price_c_name, price_c_code,
	round( avg(cp_price_value), 2) AS averged_price_2006
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year = ('2018') AND  price_c_code IN (111301, 114201)
GROUP BY price_c_name 
;


SELECT price_c_name, price_c_code,
	round( avg(cp_price_value), 2) AS averged_price_2006_and_2018
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201)
GROUP BY price_c_name 
;


SELECT price_c_name, price_c_code,
	round( avg(cp_price_value), 2) AS averged_price_2006
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year = '2006' AND price_c_name = 'mléko polotučné pasterizované'
GROUP BY price_c_name 
HAVING averged_price_2006 IS NOT NULL
;

SELECT price_c_name, price_c_code, price_c_value, price_c_unit, 
	round( avg(cp_price_value), 2) AS averged_price
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201)
GROUP BY price_c_name 
;

SELECT 
	round (avg (value), 2) AS averged_payroll
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND payroll_value_type_code = 5958
;


SELECT price_c_name, price_c_code, price_c_unit, 
		round (avg (value), 2) AS averged_payroll,
		sum (averged_payroll) / sum (averged_price) AS Celkem
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND payroll_value_type_code = 5958
AND  price_c_name IN  (
	SELECT  price_c_name, price_c_code, price_c_value, price_c_unit, 
		round( avg(cp_price_value), 2) AS averged_price
	FROM t_martin_faraday_project_sql_primary_final tmfpspf 
	WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201) 
	GROUP BY price_c_name 
	);

SELECT price_c_name, price_c_code, price_c_value, price_c_unit, 
	round( avg(cp_price_value), 2) AS average_price,
	round (avg (value), 2) AS average_payroll
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201) AND payroll_value_type_code = 5958
GROUP BY price_c_name 
;

------------

SELECT price_c_name,  price_c_unit, 
	round( avg(cp_price_value), 2) AS averged_price,
	round (avg (value), 2) AS averged_payroll,
	round( (sum(avg(value)) / sum(avg(cp_price_value))), 2) AS celkem_mnozstvi
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201) AND payroll_value_type_code = 5958
GROUP BY price_c_name 
HAVING sum(avg(value)) IS NOT NULL AND sum(avg(cp_price_value)) IS NOT NULL
;

SELECT 	price_c_name , round( (sum(avg(value)) / sum(avg(cp_price_value))), 2) AS celkem_mnozstvi
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE price_c_name IN (
	SELECT  price_c_name,
		round( avg(cp_price_value), 2) AS averged_price,
		round (avg (value), 2) AS averged_payroll,
	FROM t_martin_faraday_project_sql_primary_final tmfpspf 
	WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201) AND payroll_value_type_code = 5958
	GROUP BY price_c_name 
	);
	
	
SELECT price_c_name, price_c_code, price_c_value, price_c_unit, 
	round( avg(cp_price_value), 2) AS average_price,
	round (avg (value), 2) AS average_payroll,
	round( (avg(value)) / (avg(cp_price_value)), 2) AS Total_quantity
FROM t_martin_faraday_project_sql_primary_final tmfpspf 
WHERE payroll_year IN (2006, 2018) AND  price_c_code IN (111301, 114201) AND payroll_value_type_code = 5958
GROUP BY price_c_name 
;


