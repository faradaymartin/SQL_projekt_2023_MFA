

SELECT
    cpib.name AS nazev_pozice,
    cp2.value AS prumerna_mzda,
    cp2.payroll_year AS rok
FROM czechia_payroll cp2
JOIN czechia_payroll_industry_branch cpib ON cp2.value_type_code = 5958
GROUP BY cpib.name, cp2.payroll_year
ORDER BY CP2.payroll_year
;



SELECT
    cpc.name AS kategorie_potravin,
    cp.value AS prumerna_cena,
    YEAR(cp.date_from) AS rok
FROM czechia_price cp
JOIN czechia_price_category cpc ON cp.category_code = cpc.code
GROUP BY cpc.name, YEAR(cp.date_from)
ORDER BY YEAR(cp.date_from)
;

----- view

CREATE VIEW v_pracovni_pozice4 AS
SELECT
    cpib.name AS nazev_pozice,
    cp2.value AS prumerna_mzda,
    cp2.payroll_year AS rok
FROM czechia_payroll cp2
JOIN czechia_payroll_industry_branch cpib ON cp2.value_type_code = 5958
GROUP BY cpib.name, cp2.payroll_year
ORDER BY CP2.payroll_year
;



CREATE VIEW v_kategorie_potravin4 AS
SELECT
    cpc.name AS kategorie_potravin,
    cp.value AS prumerna_cena,
    YEAR(cp.date_from) AS rok
FROM czechia_price cp
JOIN czechia_price_category cpc ON cp.category_code = cpc.code
GROUP BY cpc.name, YEAR(cp.date_from)
ORDER BY YEAR(cp.date_from)
;

-- PŘEDKONTROLA

SELECT 
	vpp4.nazev_pozice,
	vpp4.prumerna_mzda,
	vkp4.kategorie_potravin,
	vkp4.prumerna_cena,
	vkp4.rok
FROM v_pracovni_pozice4 vpp4
JOIN v_kategorie_potravin4 vkp4
	ON vpp4.rok = vkp4.rok
;

-- ZALOŽENÍ TABULKY

CREATE TABLE t_Martin_Faraday_project_SQL_primary_final2 AS
SELECT 
	vpp4.nazev_pozice,
	vpp4.prumerna_mzda,
	vkp4.kategorie_potravin,
	vkp4.prumerna_cena,
	vkp4.rok
FROM v_pracovni_pozice4 vpp4
JOIN v_kategorie_potravin4 vkp4
	ON	vpp4.rok = vkp4.rok
;

-- KONTROLA DAT

SELECT *
FROM t_Martin_Faraday_project_SQL_primary_final2
;
