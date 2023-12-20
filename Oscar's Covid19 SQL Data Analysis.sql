# Reading the Covid_deaths table
SELECT *
FROM covid_deaths
ORDER BY 3,4;

#Viewing the pupulation,total_cases, new_cases and total_deaths recorded each day in China
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'China'
ORDER BY 1,2;

#Viewing the pupulation,total_cases, new_cases and total_deaths recorded each day in USA
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'United States'
ORDER BY 1,2;

# USA vs CHINA
#Checking for total_cases and total_deaths in USA and China using CTE
WITH Chinese_Data AS (
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'China'
),
USA_Data AS(
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'United States'
)
SELECT u.location,
	u.date,
    MAX(u.total_cases) AS total_cases_USA,
    MAX(c.total_deaths) AS total_deaths_USA, 
    c.location,
    MAX(c.total_cases) AS China_total_cases,
    MAX(c.total_deaths) AS China_total_deaths
FROM USA_Data u
JOIN Chinese_Data c
ON u.date=c.date
GROUP BY 1,2,5
ORDER BY 2

#Checking percentages of cases,deaths with regards to population of USA and China
WITH Chinese_Data AS (
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'China'
),
USA_Data AS(
SELECT location, population, date,total_cases, new_cases, total_deaths
FROM covid_deaths
WHERE location LIKE 'United States'
)
SELECT u.location,
	u.date,
    MAX(u.total_cases/u.population) * 100 AS percentage_cases_USA,
    MAX(u.total_deaths/u.total_cases) * 100 AS percentage_deaths_USA, 
    c.location,
    MAX(c.total_cases/c.population) * 100 AS percentage_cases_China,
    MAX(c.total_deaths/c.total_cases) * 100 AS percentage_deaths_China
FROM USA_Data u
JOIN Chinese_Data c
ON u.date=c.date
GROUP BY 1,2,5
ORDER BY 2

#countries with the highest record of cases
SELECT location,
	MAX(total_cases) AS total_cases
FROM covid_deaths
GROUP BY 1
ORDER BY 2 DESC

#countries with the highest record of deaths
SELECT location,
	MAX(total_deaths) AS total_deaths
FROM covid_deaths
GROUP BY 1
ORDER BY 2 DESC

#Countries with the highest percentage record of total_cases with regards to their population
SELECT 
    location,
    max_population,
    MAX(total_cases) AS total_cases, 
    MAX(total_deaths) AS total_deaths,
    MAX(total_cases/max_population) * 100 AS infected_pop_percent,
    MAX(total_deaths/total_cases) * 100 AS death_rate_percent
FROM (
    SELECT 
        location,
        MAX(population) AS max_population,
        MAX(total_cases) AS total_cases, 
        MAX(total_deaths) AS total_deaths
    FROM covid_deaths
    GROUP BY 1
) sub
GROUP BY 1,2
ORDER BY 5 DESC
LIMIT 1000

#Continents with the highest record of cases
SELECT location,
	MAX(total_cases) AS total_cases
FROM covid_deaths
WHERE continent LIKE '%0%'
GROUP BY 1
ORDER BY 2 DESC

#Continents with the highest record of deaths
SELECT location,
	MAX(total_deaths) AS total_deaths
FROM covid_deaths
WHERE continent LIKE '%0%'
GROUP BY 1
ORDER BY 2 DESC

#Global Figures per day
SELECT 
    date
    SUM(total_cases) AS total_cases,
    MAX(total_deaths) AS total_deaths,
    (MAX(total_deaths)/SUM(total_cases)) * 100 AS Death_percentage 
FROM covid_deaths
GROUP BY 1
ORDER BY 1
LIMIT 0, 1000;

#Global Records
SELECT SUM(population) World_Population, 
	SUM(total_cases) total_cases, 
	SUM(total_deaths) total_deaths, 	
    SUM(total_cases)/SUM(population) * 100 Percentage_Infected, 
	SUM(total_deaths)/SUM(total_cases) * 100 Percentage_deaths
FROM covid_deaths
WHERE continent LIKE '%0%'
ORDER BY 1

