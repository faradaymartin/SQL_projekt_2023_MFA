
CREATE TABLE t_Martin_Faraday_project_SQL_secondary_final AS
SELECT 
	c.country, c.abbreviation, c.avg_height, c.calling_code, c.capital_city, 
	c.continent, c.currency_name, c.religion, c.currency_code, c.domain_tld, 
	c.elevation, c.north, c.south, c.west, c.east, c.government_type, c.independence_date, 
	c.iso_numeric, c.landlocked, c.life_expectancy, c.national_symbol, c.national_dish, 
	c.population_density, c.population, c.region_in_world, c.surface_area, 
	c.yearly_average_temperature, c.median_age_2018, c.iso2, c.iso3, e.year, 
	e.GDP, e.population AS population_economist, e.gini, e.taxes, e.fertility, e.mortaliy_under5  
FROM countries c 
JOIN economies e 
	ON c.country = e.country
;

SELECT *
FROM t_Martin_Faraday_project_SQL_secondary_final;