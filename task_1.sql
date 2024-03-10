
-- task_1: 
/* Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
*/ 

-- SROVNÁNÍ MEZD V LETECH

SELECT
    nazev_pozice,
    rok,
    AVG(prumerna_mzda) AS PrumernaMzda
FROM
    t_Martin_Faraday_project_SQL_primary_final2
GROUP BY
    nazev_pozice,
    rok
ORDER BY
    nazev_pozice,
    rok;
   
-- FINÁL VÝSLEDEK  
   
SELECT
    nazev_pozice,
    rok,
    PrumernaMzda,
    PredchoziPrumernaMzda,
    (PrumernaMzda - PredchoziPrumernaMzda) / PredchoziPrumernaMzda * 100 AS ZmenaPercent
FROM
    (
        SELECT
            nazev_pozice,
            rok,
            AVG(prumerna_mzda) AS PrumernaMzda,
            LAG(AVG(prumerna_mzda)) OVER (PARTITION BY nazev_pozice ORDER BY rok) AS PredchoziPrumernaMzda
        FROM
            t_Martin_Faraday_project_SQL_primary_final2
        GROUP BY
            nazev_pozice,
            rok
    ) AS Data
ORDER BY
    nazev_pozice,
    rok;
