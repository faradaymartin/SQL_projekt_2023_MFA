-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji 
-- v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

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

SELECT country , GDP , `year` 
FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
WHERE country LIKE  '%cz%'
;

SELECT t1.year, t1.average_GDP,
	ROUND( ((t1.average_GDP - t2.average_GDP) / t2.average_GDP) * 100, 2) AS percentage_difference_GDP
FROM 
	(
	SELECT YEAR , AVG(GDP) AS average_GDP
	FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
	WHERE country = 'czech republic'
	GROUP BY YEAR
	ORDER BY YEAR
	)t1
JOIN (
	SELECT YEAR , AVG(GDP) AS average_GDP
	FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
	WHERE country = 'czech republic'
	GROUP BY YEAR
	ORDER BY YEAR
	)t2 ON  t1.year = t2.year + 1
WHERE ((t1.average_GDP - t2.average_GDP) / t2.average_GDP) * 100 > 1
ORDER BY YEAR  DESC
;

SELECT year, percentage_difference_GDP, percentage_difference
FROM (
    SELECT t1.year, t1.average_GDP,
        ROUND((((t1.average_GDP - t2.average_GDP) / t2.average_GDP) * 100), 2) AS percentage_difference_GDP,
        NULL AS payroll_year, NULL AS average_price, NULL AS percentage_difference
    FROM 
        (
        SELECT YEAR , AVG(GDP) AS average_GDP
        FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
        WHERE country = 'czech republic'
        GROUP BY YEAR
        ORDER BY YEAR
        )t1
    JOIN (
        SELECT YEAR , AVG(GDP) AS average_GDP
        FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
        WHERE country = 'czech republic'
        GROUP BY YEAR
        ORDER BY YEAR
        )t2 ON  t1.year = t2.year + 1
    UNION ALL
    SELECT t1.payroll_year, NULL AS average_GDP, NULL AS percentage_difference_GDP,
        t1.payroll_year, t1.average_price, 
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
) AS union_table
WHERE year >= 2007 
ORDER BY year DESC
;

----

SELECT *
FROM (
    SELECT t1.year, t1.average_GDP,
        ROUND((((t1.average_GDP - t2.average_GDP) / t2.average_GDP) * 100), 2) AS percentage_difference_GDP,
        NULL AS payroll_year, NULL AS average_price, NULL AS percentage_difference, NULL AS percentage_difference_PAYROLL
    FROM 
        (
        SELECT YEAR , AVG(GDP) AS average_GDP
        FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
        WHERE country = 'czech republic'
        GROUP BY YEAR
        ORDER BY YEAR
        )t1
    JOIN (
        SELECT YEAR , AVG(GDP) AS average_GDP
        FROM t_martin_faraday_project_sql_secondary_final tmfpssf 
        WHERE country = 'czech republic'
        GROUP BY YEAR
        ORDER BY YEAR
        )t2 ON  t1.year = t2.year + 1
    UNION ALL
    SELECT t1.payroll_year, NULL AS average_GDP, NULL AS percentage_difference_GDP,
        t1.payroll_year, t1.average_price, 
        ROUND((((t1.average_price - t2.average_price) / t2.average_price) * 100),2) AS percentage_difference, NULL AS percentage_difference_PAYROLL
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
    UNION ALL 
    SELECT t1.year, NULL AS average_GDP, NULL AS percentage_difference_GDP, NULL AS payroll_year, NULL AS average_price, NULL AS percentage_difference, 
	ROUND((((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100),2) AS percentage_difference_PAYROLL
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
	)t2 ON t1.year = t2.year + 1
) AS union_table
ORDER BY year DESC
;

