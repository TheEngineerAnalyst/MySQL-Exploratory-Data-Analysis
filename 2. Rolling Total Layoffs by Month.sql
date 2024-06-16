# Rolling Total Layoffs by month

select substring(`date`,1,7) as month, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;

# sum of layoffs for each month

with Rolling_Total as 
(
select substring(`date`,1,7) as month, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off,
sum(total_off) over(order by `month`) as rolling_total
from Rolling_total;

