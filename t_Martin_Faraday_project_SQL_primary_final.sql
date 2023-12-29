

SELECT *
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
JOIN czechia_region cr 
	ON cp2.region_code = cr.code
JOIN czechia_price_category cpc2 
	ON cp2.category_code = cpc2.code 
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
SELECT cp.id, cp.value, cp.calculation_code, cpc.name AS payroll_name, cp.industry_branch_code, 
	cpib.name AS industri_name, cp.payroll_year, cp.payroll_quarter, cpu.code AS pyaroll_unit_code, 
	cpu.name AS pyaroll_unit_name, cpvt.code AS payroll_value_type_code, cpvt.name AS payroll_value_type_name, 
	cp2.id AS cp_id, cp2.value AS cp_price_value, cp2.category_code AS cp_produkt_code, cp2.date_from, 
	cp2.region_code, cr.name AS region_name, cpc2.code AS price_c_code, cpc2.name AS price_c_name, 
	cpc2.price_value AS price_c_value, cpc2.price_unit AS price_c_unit
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
JOIN czechia_region cr 
	ON cp2.region_code = cr.code
JOIN czechia_price_category cpc2 
	ON cp2.category_code = cpc2.code
WHERE cp.calculation_code IS NOT NULL 
AND cpc.code IS NOT NULL 
AND cp.industry_branch_code IS NOT NULL 
AND cpib.code IS NOT NULL AND cp.unit_code IS NOT NULL
AND cpu.code IS NOT NULL AND cp.value_type_code IS NOT NULL
AND cpvt.code IS NOT NULL AND cp.payroll_year IS NOT NULL
AND cp2.region_code IS NOT NULL AND cr.code IS NOT NULL
AND cp2.category_code IS NOT NULL AND cpc2.code IS NOT NULL
;


CREATE INDEX payroll_index
ON czechia_payroll (calculation_code, industry_branch_code, unit_code, value_type_code, payroll_year);

SELECT cp.id, cp.value, cp.calculation_code, cpc.name AS payroll_name, cp.industry_branch_code, 
	cpib.name AS industri_name, cp.payroll_year, cp.payroll_quarter, cpu.code AS pyaroll_unit_code, 
	cpu.name AS pyaroll_unit_name, cpvt.code AS payroll_value_type_code, cpvt.name AS payroll_value_type_name, 
	cp2.id AS cp_id, cp2.value AS cp_price_value, cp2.category_code AS cp_produkt_code, cp2.date_from, 
	cp2.region_code, cr.name AS region_name, cpc2.code AS price_c_code, cpc2.name AS price_c_name, 
	cpc2.price_value AS price_c_value, cpc2.price_unit AS price_c_unit
FROM czechia_payroll cp 
JOIN czechia_payroll_calculation cpc 
	ON cp.calculation_code = cpc.code
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
JOIN czechia_price cp2 
	ON YEAR (cp2.date_from) = cp.payroll_year 
JOIN czechia_region cr 
	ON cp2.region_code = cr.code
JOIN czechia_price_category cpc2 
	ON cp2.category_code = cpc2.code
WHERE cp.calculation_code IS NOT NULL 
AND cpc.code IS NOT NULL 
AND cp.industry_branch_code IS NOT NULL 
AND cpib.code IS NOT NULL AND cp.unit_code IS NOT NULL
AND cpu.code IS NOT NULL AND cp.value_type_code IS NOT NULL
AND cpvt.code IS NOT NULL AND cp.payroll_year IS NOT NULL
AND cp2.region_code IS NOT NULL AND cr.code IS NOT NULL
AND cp2.category_code IS NOT NULL AND cpc2.code IS NOT NULL
;
