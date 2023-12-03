--Actor table
--1. Get first_name , last_name for actors
SELECT first_name, last_name
FROM actor;

--2. Get first_name, last_name only 5 rows.
SELECT first_name, last_name
FROM actor
LIMIT 5;

--3. Get first_name, last_name of 5 actors who have been modified last
SELECT first_name, last_name, last_update FROM actor
ORDER BY first_name, last_name DESC
LIMIT 5;

--4. Get top 5 repeating last_names of actors.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
LIMIT 5;

--5. Get top 6 repeating first_name of actors.
Select first_name, count(first_name) from actor
GROUP BY first_name
ORDER BY COUNT(first_name) DESC
LIMIT 6;


--Film table
--6. Get count of films in table
SELECT COUNT(*) FROM film;

--7. What is average movie length (use length column)
select AVG(length) from film;

--8. Count of movies for each rating (use rating column)
SELECT rating, COUNT(rating) FROM film
GROUP BY rating;

--9. Get list of horror movies
select * from film
join film_category
on film_category.film_id=film.film_id
join category
on category.category_id=film_category.category_id
where category.category_id=11;

--10. Movies that contain CAT in title.
Select * from film
where title like 'CAT%'

--Category
--11. How many movie categories are there?
Select COUNT(*) from category;

--12. Are category names repeating ?
select category.name, count(category.name) from category
group by category.name
having count(category.name)>1;
--hence, they are not repeating

--Country & City
13. how many countries and cities ?
Select COUNT(country) from country;
Select COUNT(city) from city;

--14. For each country get the list of cities.
Select city from city
join country
on city.last_update=country.last_update;

--Customer
--15. Get list of active customers;
Select * from customer
where active = 1;

--16. Do any customer share same emailID
select email, count(email) from customer
group by email
having count(email)>1;
--no

--17. List of customers with same lastname
select last_name, count(last_name) from customer
group by last_name
having count(last_name)>1;

--film_category
--18. Total movies that are categoried
select count(category_id) from film_category;

--19. Total rows in inventory
Select count(*)from inventory;





