# Data Source: https://www.kaggle.com/gpreda/covid-world-vaccination-progress?select=country_vaccinations_by_manufacturer.csv

--- Orginal data
SELECT *
FROM COVID19.dbo.country_vaccinations

--- Total doses of vaccine for each manufacturer
SELECT vaccine, SUM(total_vaccinations) AS total_manu_vaccine
FROM COVID19.dbo.country_vaccinations cv
INNER JOIN(
SELECT locationn, max(date) as max_date
FROM COVID19.dbo.country_vaccinations
group by locationn
) tb
ON tb.locationn = cv.locationn AND tb.max_date = cv.date
GROUP BY vaccine

--- Total doses of vaccine for each manufacturer (by country)
SELECT cv.locationn, vaccine, total_vaccinations
FROM COVID19.dbo.country_vaccinations cv
INNER JOIN(
SELECT locationn, max(date) as max_date
FROM COVID19.dbo.country_vaccinations
group by locationn
) tb
ON tb.locationn = cv.locationn AND tb.max_date = cv.date

--- Total doses of vaccine for each country
DROP TABLE IF EXISTS #temp_vaccine
CREATE TABLE #temp_vaccine(
locationn varchar(50),
vaccine varchar(100),
total_vaccinations bigint
)

INSERT INTO #temp_vaccine
SELECT cv.locationn, vaccine, total_vaccinations
FROM COVID19.dbo.country_vaccinations cv
INNER JOIN(
	SELECT locationn, max(date) as max_date
	FROM COVID19.dbo.country_vaccinations
	group by locationn
) tb
ON tb.locationn = cv.locationn AND tb.max_date = cv.date

SELECT locationn, SUM(total_vaccinations) AS total_doses_vaccine
FROM #temp_vaccine
GROUP BY locationn

--- Doses of vaccine by country per day
SELECT locationn, date, SUM(total_vaccinations) as vaccine_doses
FROM COVID19.dbo.country_vaccinations
GROUP BY locationn, date
ORDER BY locationn, date ASC
