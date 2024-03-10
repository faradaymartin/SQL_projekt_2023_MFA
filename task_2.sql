
-- task_2: 
/* Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd
*/

-- FINÁLNÍ DATA, ZA OBĚ SLEDOVANÉ OBDOBÍ

SELECT kategorie_potravin, prumerna_cena, rok,
	round( avg(prumerna_cena), 2) AS PrumernaCena,
	round (avg (prumerna_mzda), 2) AS PrumernaMzda,
	round( (avg(prumerna_mzda)) / (avg(prumerna_cena)), 2) AS Total_quantity
FROM t_Martin_Faraday_project_SQL_primary_final2
WHERE rok  IN (2006, 2018) AND  kategorie_potravin  IN ('chléb konzumní kmínový', 'mléko polotučné pasterované') AND prumerna_mzda
GROUP BY prumerna_cena 
;