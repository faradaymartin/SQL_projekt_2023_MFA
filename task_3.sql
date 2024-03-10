
-- task_3: 
/* Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
*/ 

-- SROVNÁNÍ CEN POTRAVIN V LETECH

SELECT
    kategorie_potravin,
    rok,
    AVG(prumerna_cena) AS PrumernaCena
FROM
    t_Martin_Faraday_project_SQL_primary_final2
GROUP BY
    kategorie_potravin,
    rok
ORDER BY
    kategorie_potravin,
    rok;
    
-- MEZIROČNÍ PERCENTNÍ ROZDÍL 
   
SELECT
    kategorie_potravin,
    rok,
    PrumernaCena,
    PredchoziPrumernaCena,
    (PrumernaCena - PredchoziPrumernaCena) / PredchoziPrumernaCena * 100 AS ZmenaPercent
FROM
    (
        SELECT
            kategorie_potravin,
            rok,
            AVG(prumerna_cena) AS PrumernaCena,
            LAG(AVG(Prumerna_Cena)) OVER (PARTITION BY kategorie_potravin ORDER BY rok) AS PredchoziPrumernaCena
        FROM
            t_Martin_Faraday_project_SQL_primary_final2
        GROUP BY
            kategorie_potravin,
            rok
    ) AS Data
ORDER BY
    kategorie_potravin,
    rok;

   
-- FINÁLNÍ VÝSLEDEK
   
WITH PrumernaZmena AS (
    SELECT
        kategorie_potravin,
        AVG(prumerna_cena) AS PrumernaCena,
        LAG(AVG(prumerna_cena)) OVER (PARTITION BY kategorie_potravin ORDER BY rok) AS PredchoziPrumernaCena
    FROM
        t_Martin_Faraday_project_SQL_primary_final2
    GROUP BY
        kategorie_potravin
)
SELECT
    kategorie_potravin,
    PrumernaCena,
    PredchoziPrumernaCena,
    (PrumernaCena - PredchoziPrumernaCena) / PredchoziPrumernaCena * 100 AS ZmenaPercent
FROM
    PrumernaZmena
ORDER BY
    ZmenaPercent ASC
LIMIT 1;
