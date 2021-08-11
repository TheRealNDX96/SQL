--- Data Source: https://www.kaggle.com/gpreda/covid-world-vaccination-progress?select=country_vaccinations.csv
--- Database name is COVID19 and table name is country_vacc

--- Original Data
SELECT *
FROM COVID19.dbo.country_vacc

--- People vaccinated per hundred based on latest available date for each country
SELECT co.country, total_vaccinations, total_vaccinations_per_hundred, people_vaccinated_per_hundred
FROM COVID19.dbo.country_vacc co
INNER JOIN
(SELECT country, max(date) AS max_date
FROM COVID19.dbo.country_vacc
GROUP BY country 
) md
ON md.max_date = co.date AND md.country = co.country
