
-- task_4: 
/* Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 */

-- ZPRACOVÁNÍ DOTAZU, JENDA VERZE

SELECT rok,
       AVG(prumerna_cena) AS Prumerna_Cena_Potravin,
       AVG(prumerna_mzda) AS Prumerna_Mzda,
       (AVG(prumerna_cena) / AVG(prumerna_mzda) - 1) * 100 AS Procentualni_Zmena
FROM t_Martin_Faraday_project_SQL_primary_final2
GROUP BY rok
HAVING AVG(prumerna_cena) > 1.1 * AVG(prumerna_mzda)
;

-- FINÁLNÍ VÝSLEDEK

CREATE VIEW RozdilMeziMzdamiACenami AS
SELECT rok,
       AVG(prumerna_cena) AS Prumerna_Cena_Potravin,
       AVG(prumerna_mzda) AS Prumerna_Mzda,
       (AVG(prumerna_cena) / AVG(prumerna_mzda) - 1) * 100 AS ProcentualniZmena
FROM t_Martin_Faraday_project_SQL_primary_final2
GROUP BY rok;


SELECT * FROM RozdilMeziMzdamiACenami;


