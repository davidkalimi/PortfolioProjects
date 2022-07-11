select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4 

--select *
--from PortfolioProject..CovidVactionations
--order by 3,4 

--select Data that we are going to be using
select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select location, date, total_cases , total_deaths, (total_deaths/total_cases) *100 as DeathPercantage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2

--looking at Total Cases vs Population
-- Shows what percentage of population got Covid

select location, date, total_cases ,population, (total_cases/ population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
order by 1,2

--looking at Countries with Highest Infection Rate Compared to Population
select location, population, MAX (total_cases)as HiighestInfectionCount ,  max((total_cases/ population)*100) as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by population, location
order by PercentPopulationInfected desc

--Showing Countries with Highest Death Count prt Popoulation
select location, MAX (cast(total_cases as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by  location
order by TotalDeathCount desc

--Lets break things down by continent
select continent, MAX (cast(total_cases as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by  continent
order by TotalDeathCount desc

--showing continents with the highest death count per population
select continent, MAX (cast(total_cases as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by  continent
order by TotalDeathCount desc

--global numbers

select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) *100 as DeathPercantage
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
order by 1,2

-- looking at total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
,sum(cast (vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVactionations vac
 on dea.location = vac.location and dea.date = vac.date
 where dea.continent is not null
 --order by 1,2,3

-- use cte
with PopvsVac (continent, location,date, population,new_vaccinations, rollingpeoplevaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(convert(bigint,vac.new_vaccinations))
over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVactionations vac
 on dea.location = vac.location and dea.date = vac.date
 where dea.continent is not null
 --order by 1,2,3
)
select *, (rollingpeoplevaccinated/population) * 100
from PopvsVac

-- temp table
drop table if exists percentPopulationVaccinated
create table percentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into percentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(convert(bigint,vac.new_vaccinations))
over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVactionations vac
 on dea.location = vac.location and dea.date = vac.date
 --where dea.continent is not null

 select *, (rollingpeoplevaccinated/population) * 100
from percentPopulationVaccinated

--Creating view to store data for later visualizations
create view percentPopulationVaccinated2 as
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(convert(bigint,vac.new_vaccinations))
over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVactionations vac
 on dea.location = vac.location and dea.date = vac.date
 where dea.continent is not null
 --order by 2,3
 select *
 from percentPopulationVaccinated2
