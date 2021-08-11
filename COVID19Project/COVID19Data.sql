--- Data Source: https://www.kaggle.com/fedesoriano/coronavirus-covid19-vaccinations-data
--- Database name is COVID19 and table name is COVID19Data

SELECT *
FROM COVID19.dbo.COVID19Data

--- Total cases per continent
SELECT continent, SUM(new_cases) AS total_cases_continent
FROM COVID19.dbo.COVID19Data
WHERE continent IS NOT NULL
GROUP BY continent

--- Death rate of infected country
SELECT location, date, CAST(total_deaths AS float)/CAST(total_cases AS float) AS infected_death_rate
FROM COVID19.dbo.COVID19Data
WHERE continent IS NOT NULL

--- Total cases against population density for latest date
SELECT sub.location, ori.total_cases, population_density
FROM COVID19.dbo.COVID19Data ori
INNER JOIN(
SELECT location, max(date) AS date
FROM COVID19.dbo.COVID19Data
GROUP BY location
) sub
ON ori.date = sub.date AND sub.location = ori.location
WHERE total_cases IS NOT NULL AND continent IS NOT NULL

--- Singapore Stringency Index against new_cases
SELECT location, date, new_cases, stringency_index
FROM COVID19.dbo.COVID19Data
WHERE location = 'singapore' AND stringency_index IS NOT NULL
