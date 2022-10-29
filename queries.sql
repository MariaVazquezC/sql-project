use schools;

select *
from schools.comments;

create view top_schools as
select school, AVG(curriculum)
from schools.comments
group by school
order by AVG(curriculum) DESC;

select avg(priceMax) from schools.price as average_price;

SELECT DISTINCT * 
FROM schools.schools
INNER JOIN schools.price
ON schools.schools.school_id = schools.price.school_id
order by priceMax DESC;

select *
from schools.comments
order by createdAt DESC;

SELECT *
FROM schools.schools
INNER JOIN schools.locations
ON schools.schools.school_id = schools.locations.school_id
order by schools.locations.description asc;

SELECT school, AVG(jobSupport), AVG(curriculum), AVG(overall)
FROM schools.comments
GROUP BY school
ORDER BY AVG(jobSupport) DESC;

SELECT distinct schools.comments.id, review_body, createdAt, school, curriculum, jobSupport
FROM schools.courses
JOIN schools.comments
ON schools.courses.school_id = schools.comments.school_id
WHERE schools.comments.school = 'le-wagon'
ORDER BY jobSupport ASC;

SELECT AVG(priceMax) as bootcamp_avg_price
from schools.price;

CREATE TEMPORARY TABLE schools.bootcamps_above_avg
SELECT school_id 
FROM schools.price as bootcamps_above_avg
WHERE priceMax > (SELECT AVG(priceMax) from schools.price);

/*DROP TEMPORARY TABLE schools.bootcamps_above_avg*/

SELECT *
FROM schools.bootcamps_above_avg;

SELECT * 
from schools.schools;

SELECT schools.bootcamps_above_avg.school_id, schools.schools.school
FROM schools.bootcamps_above_avg
INNER JOIN schools.schools ON schools.bootcamps_above_avg.school_id = schools.school_id;

CREATE TEMPORARY TABLE schools_name_above_avg
SELECT schools.bootcamps_above_avg.school_id, schools.schools.school
FROM schools.bootcamps_above_avg
INNER JOIN schools.schools ON schools.bootcamps_above_avg.school_id = schools.school_id;

CREATE TEMPORARY TABLE top_school_prices
SELECT schools.schools_name_above_avg.school_id, schools.schools_name_above_avg.school, schools.price.priceMax
FROM schools.schools_name_above_avg
INNER JOIN schools.price ON schools.schools_name_above_avg.school_id = price.school_id
ORDER BY priceMax DESC;

SELECT schools.top_school_prices.school_id, schools.top_school_prices.school, schools.top_school_prices.priceMax, schools.badges.name
FROM schools.top_school_prices
INNER JOIN schools.badges ON schools.top_school_prices.school_id = badges.school_id
ORDER BY priceMax DESC;

SELECT *
FROM top_school_prices;

SELECT schools.top_school_prices.school_id, schools.top_school_prices.school, schools.top_school_prices.priceMax, schools.badges.name, comments.overallScore
FROM schools.top_school_prices
INNER JOIN schools.badges ON schools.top_school_prices.school_id = badges.school_id
INNER JOIN schools.comments ON schools.top_school_prices.school_id = comments.school_id
GROUP BY school, priceMax
ORDER BY AVG(overallScore) DESC;
