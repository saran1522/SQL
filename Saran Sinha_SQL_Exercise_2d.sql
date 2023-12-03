 --Aggregate Queries
--1. Count of movies acted by actor with actor list in descending order (by count of movies acted).
select actor.actor_id,actor.first_name,actor.last_name,count(film_actor.film_id)
from actor 
join film_actor
on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by count(film_actor.film_id) desc

--2.0  Which actor has highest "Average movie rating
SELECT a.actor_id, a.first_name,a.last_name, count(i.rating) AS "average_rating"
FROM actor a
JOIN film_actor f ON a.actor_id = f.actor_id
JOIN film i ON f.film_id = i.film_id
GROUP BY a.actor_id, a.first_name
ORDER BY "average_rating" DESC
LIMIT 1;

--3.0  Count of movies per language
select language.language_id,language.name,count(film.film_id)
from language
join film
on film.language_id=language.language_id
group by language.language_id

--4.1 How many movies of same film are stored in each store
SELECT s.store_id, f.title, COUNT(i.film_id) AS movie_count
FROM store s
JOIN inventory  i ON i.store_id = s.store_id
JOIN film f ON f.film_id = i.film_id
GROUP BY s.store_id, f.title
order by movie_count desc;

--4.2 How many unique movies in each store.
SELECT 
  COUNT (Distinct(film_id) )
FROM inventory
GROUP BY store_id;

--5.0 Average length of movies
SELECT AVG(length) from film;

--6.0 Which language movies are longest
select language.language_id,language.name,avg(film.length) as avg_length
from language
join film
on language.language_id = film.language_id
group by language.language_id
order by avg(film.length) desc

--7.0 Which language movies have highest rating
select language.language_id,language.name,avg(film.rental_rate) as avg_length
from language
join film
on language.language_id = film.language_id
group by language.language_id
order by avg(film.rental_rate) desc

--8.0 Count of movies by category
SELECT c.name, COUNT(f.film_id) AS film
FROM category c
JOIN film_category f ON f.category_id =c.category_id
GROUP BY c.name
order by film desc;

--9.0 Top 3 actors who worked in horror movies
select actor.actor_id,actor.first_name,actor.last_name ,count(film_actor.film_id)
from actor
join film_actor 
on film_actor.actor_id = actor.actor_id
join film_category
on film_actor.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
where category.name = 'Horror'
group by actor.actor_id
order by count(film_actor.film_id) desc
limit 3

--10.0  Top 3 actors who acted in action or romantic movies.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS num_movies
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name='Action' or c.name='Romantic'
GROUP BY a.actor_id
ORDER BY num_movies DESC
LIMIT 3;

--11.0 Count of movies rented by Country
SELECT c.country, COUNT(DISTINCT f.film_id)
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN customer cus ON cus.customer_id = r.customer_id
JOIN address a ON a.address_id = cus.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country c ON c.country_id = ci.country_id
GROUP BY c.country
ORDER BY COUNT(DISTINCT f.film_id) DESC;


--13.0 Number of employees in each store
select store.store_id,count(staff.staff_id)
from store
join staff
on store.store_id = staff.store_id
group by store.store_id

--15.0 Which employee has rented move movies and what is earning amount per flim.
SELECT 
  s.staff_id,
  s.first_name || ' ' || s.last_name AS staff_name,
  COUNT(r.rental_id) AS num_rentals,
  SUM(f.rental_rate) AS total_earnings
FROM staff s
JOIN rental r ON s.staff_id = r.staff_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY s.staff_id
ORDER BY num_rentals DESC;



