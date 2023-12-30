
-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, AVG(value) AS average_payroll
FROM t_martin_faraday_project_sql_primary_final tmfpspf
WHERE payroll_value_type_code = 5958
GROUP BY industry_branch_code, industri_name, YEAR(date_from)
ORDER BY industry_branch_code, YEAR(date_from);


SELECT t1.industri_name, t1.year, t1.average_payroll,
	((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100 AS percentage_difference
FROM 
	(
	SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY industry_branch_code, industri_name, YEAR(date_from)
	ORDER BY industry_branch_code, YEAR(date_from)
	)t1
JOIN (
	SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY industry_branch_code, industri_name, YEAR(date_from)
	ORDER BY industry_branch_code, YEAR(date_from)
	)t2 ON t1.industri_name = t2.industri_name AND t1.year = t2.year + 1
ORDER BY t1.industri_name, t1.year ASC  
;

SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, MIN(value) AS min_payroll_increase
FROM t_martin_faraday_project_sql_primary_final tmfpspf
WHERE payroll_value_type_code = 5958
GROUP BY industry_branch_code, industri_name, YEAR(date_from)
ORDER BY industry_branch_code, YEAR(date_from)
;


SELECT t1.industri_name, t1.year, t1.average_payroll,
	((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100 AS percentage_difference
FROM 
	(
	SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY industry_branch_code, industri_name, YEAR(date_from)
	ORDER BY industry_branch_code, YEAR(date_from)
	)t1
JOIN (
	SELECT industry_branch_code, industri_name, YEAR(date_from) AS year, AVG(value) AS average_payroll
	FROM t_martin_faraday_project_sql_primary_final tmfpspf
	WHERE payroll_value_type_code = 5958
	GROUP BY industry_branch_code, industri_name, YEAR(date_from)
	ORDER BY industry_branch_code, YEAR(date_from)
	)t2 ON t1.industri_name = t2.industri_name AND t1.year = t2.year + 1
WHERE ((t1.average_payroll - t2.average_payroll) / t2.average_payroll) * 100 < 0
ORDER BY t1.industri_name ASC
;
percentage_difference, t1.YEAR, 
