-- Otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- procentní nárust cen potravin

SELECT t1.payroll_year, t1.average_price, 
    ((t1.average_price - t2.average_price) / t2.average_price) * 100 AS percentage_difference
FROM (
    SELECT payroll_year, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year
) t1
JOIN (
    SELECT payroll_year, AVG(cp_price_value) AS average_price
    FROM t_martin_faraday_project_sql_primary_final tmfpspf 
    GROUP BY payroll_year
) t2 ON t1.payroll_year = t2.payroll_year + 1
WHERE ((t1.average_price - t2.average_price) / t2.average_price) * 100 > 1
ORDER BY payroll_year
;

-- procentní nárust mezd

SELECT t1.year, t1.average_payroll,
	((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100 AS percentage_difference
FROM 
	(
	SELECT YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY YEAR(date_from)
	ORDER BY YEAR(date_from)
	)t1
JOIN (
	SELECT YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY YEAR(date_from)
	ORDER BY YEAR(date_from)
	)t2 ON  t1.year = t2.year + 1
WHERE ((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100 > 1
ORDER BY percentage_difference DESC  
;


