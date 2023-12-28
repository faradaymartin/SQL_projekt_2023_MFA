

SELECT *
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
LEFT JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
;

SELECT *
FROM czechia_payroll cp 
JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
	;

SELECT 
	cp.id,
	cp.value ,
	cp.category_code,
	cp.date_from,
	cp.date_to,
	cp.region_code,
	cr.name 
FROM czechia_price cp 
JOIN czechia_region cr 
	ON cp.region_code = cr.code 
	;

WITH regions AS (
SELECT 
	cp1.id AS cp1_ID,
	cp1.value ,
	cp1.category_code,
	cp1.date_from,
	cp1.date_to,
	cp1.region_code,
	cr.name 
FROM czechia_price cp1 
JOIN czechia_region cr 
	ON cp1.region_code = cr.code 
)
SELECT *
FROM regions



CREATE VIEW TEST_2 AS
SELECT 
	cp1.id AS cp1_ID,
	cp1.value ,
	cp1.category_code,
	cp1.date_from,
	cp1.date_to,
	cp1.region_code,
	cr.name 
FROM czechia_price cp1 
JOIN czechia_region cr 
	ON cp1.region_code = cr.code 
;

SELECT *
FROM t_Martin_Faraday_project_SQL_primary_final;

CREATE TABLE t_Martin_Faraday_project_SQL_primary_final AS
SELECT cp.id, cp.value, cp.value_type_code, cp.unit_code, cp.calculation_code, cpc.name AS payroll_name, 
	cp.industry_branch_code, cpib.name AS industri_name, cp.payroll_year, cp.payroll_quarter, cpu.code AS pyaroll_unit_code, 
	cpu.name AS pyaroll_unit_name, cpvt.code AS payroll_value_type_code, cpvt.name AS payroll_value_type_name, cp2.id AS price_id, cp2.value AS price_value,
	cp2.category_code AS price_code, cp2.date_from, cp2.date_to, cp2.region_code, cr.name AS region_name
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
LEFT JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
LEFT JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
LEFT JOIN czechia_region cr 
	ON cp2.region_code = cr.code 
;
