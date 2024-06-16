# Company Rankings using Rolling Total Layoffs

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

with Company_Year(company, years, total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as 
(
select *, dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
)
select *
from Company_Year_Rank
where Ranking <= 5;