
-- task_5:
/* Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, 
 * pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném 
 * nebo násdujícím roce výraznějším růstem?
 */

-- PŘÍPRAVA WIEW



SELECT *
FROM PrumernyNarustCenAMez2;

SELECT *
FROM HDP_Narust2;

CREATE VIEW PrumernyNarustCenAMez2 AS
SELECT ROK,
       AVG(prumerna_cena) AS Prumerna_Cena_Potravin,
       AVG(prumerna_mzda) AS Prumerna_Mzda,
       (AVG(prumerna_cena) / LAG(AVG(prumerna_cena)) OVER (ORDER BY ROK) - 1) * 100 AS Procentualni_Narust_Cen,
       (AVG(prumerna_mzda) / LAG(AVG(prumerna_mzda)) OVER (ORDER BY ROK) - 1) * 100 AS Procentualni_Narust_Mezd
FROM t_Martin_Faraday_project_SQL_primary_final2
GROUP BY ROK;

CREATE VIEW HDP_Narust2 AS
SELECT YEAR,
       GDP,
       LAG(GDP) OVER (ORDER BY YEAR) AS Predchozi_HDP,
       ((GDP / LAG(GDP) OVER (ORDER BY YEAR)) - 1) * 100 AS Procentualni_Narust_HDP
FROM t_martin_faraday_project_sql_secondary_final
WHERE COUNTRY = 'Czech Republic';

-- FINALNÍ VÝSLEDEK

SELECT
    HDP_Narust2.YEAR,
    HDP_Narust2.Procentualni_Narust_HDP,
    PrumernyNarustCenAMez2.Procentualni_Narust_Cen,
    PrumernyNarustCenAMez2.Procentualni_Narust_Mezd
FROM HDP_Narust2
JOIN PrumernyNarustCenAMez2 ON HDP_Narust2.YEAR = PrumernyNarustCenAMez2.ROK
;
