--1. Find actors who acted in film "Lost Bird"

select * from actor
select * from film
select * from film_actor

select actor.actor_id , actor.first_name , actor.last_name from actor
join film_actor
on film_actor.actor_id=actor.actor_id
join film 
on film.film_id=film_actor.film_id
where title='Lost Bird';

--2. Find movies of "Sci-Fi" genre

select * from film
join film_category on film.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name = 'Sci-Fi';

--3. Find movies of actress 
--	first_name: "PENELOPE"	
--	last_name:"GUINESS"
 
select * from actor
join film_actor
on film_actor.actor_id=actor.actor_id
join film 
on film.film_id=film_actor.film_id
where actor.first_name = 'PENELOPE'and actor.last_name = 'GUINESS';


--4. list Genres, movies (in each Genre), actors in each movie

select film.title, category.name, actor.first_name, actor.last_name  from category
join film_category
on film_category.category_id=category.category_id
join film 
on film.film_id=film_category.film_id
 left join film_actor
on film_actor.film_id = film.film_id
join actor
on actor.actor_id = film_actor.actor_id;


--5. List films that are rented from inventory

Select * from film
join inventory
on inventory.film_id=film.film_id
join rental
on rental.inventory_id=inventory.inventory_id;


--6. List genres corresponding movies rented by customer.

select title, category.name from film
join film_category
on film_category.film_id=film.film_id
join category
on category.category_id=film_category.category_id
join inventory
on inventory.film_id=film_category.film_id
join rental
on rental.inventory_id=inventory.inventory_id
join customer
on customer.customer_id=rental.customer_id;

--7. List 5 rows of customer which have renated "Horror" generes.
select * from customer
join rental
on rental.customer_id=customer.customer_id
join inventory
on inventory.inventory_id=rental.inventory_id
join film 
on film.film_id=inventory.film_id
join film_category
on film_category.film_id=film.film_id
join category
on category.category_id=film_category.category_id
where category.name='Horror'
Limit 5;


--8. List 5 staff members who have given maximum movies on rent (best performers)
Select staff.staff_id, staff.first_name, staff.last_name, Count(staff.staff_id) 
from staff
join rental
on rental.staff_id=staff.staff_id
join inventory
on inventory.inventory_id=rental.inventory_id
join film
on film.film_id=inventory.film_id
group by staff.staff_id
order by count(staff.staff_id) desc
limit 5;


--9. List top movies types Genre (by count) rented by customers.

select category.name, count(category.name) from category
join film_category
on film_category.category_id=category.category_id
join film 
on film.film_id=film_category.film_id
join inventory
on inventory.film_id=film.film_id
join rental
on rental.inventory_id=inventory.inventory_id
join customer
on customer.customer_id=rental.customer_id
group by category.name
order by count(category.name) desc;

--10. List top movies (by count) by Genre (by count) in the inventory.
select film.film_id,film.title,category.name,count(film.film_id)
from film
join film_category
on film_category.film_id = film.film_id
join category 
on category.category_id = film_category.category_id
join inventory
on inventory.film_id = film.film_id
group by film.film_id,category.name
order by count(film.film_id) desc

--11. List of actors who have not acted in any flim.
select * from actor
left join film_actor
on film_actor.actor_id=actor.actor_id
left join film
on film.film_id=film_actor.film_id
where film.film_id is null;


--12. List of films that are not in inventory
select * from film
left join inventory
on inventory.film_id=film.film_id
where inventory.film_id is null;

--13. List of actors who are not in inventory

Select * from actor
left join film_actor
on film_actor.actor_id=actor.actor_id
left join inventory 
on inventory.film_id=film_actor.film_id
where inventory.film_id is null;

--14. List of actors whose movies are not stores.

Select * from actor
left join film_actor
on film_actor.actor_id=actor.actor_id
left join inventory
on inventory.film_id=film_actor.film_id
left join store
on store.store_id=inventory.store_id
where store.store_id is null;

--16. categories which do not have movies.
select * from category
left join film_category
on film_category.category_id=category.category_id
left join film
on film.film_id=film_category.film_id
where film.film_id is null;

--17. Actors who acted in all movie categories
select * from film_actor
right join film_category
on film_category.film_id = film_actor.film_id
where film_actor.film_id is not  null

--18. Actors who did NOT act in all movie categories
select actor.first_name, actor.last_name
from actor 
join film_actor  
on actor.actor_id = film_actor.actor_id
join film  
on film_actor.film_id = film.film_id
inner join film_category 
on film.film_id = film_category.film_id
group by actor.actor_id
having count(distinct film_category.category_id) < (select count(*) from category);

--19. List of stores with address, city, countries.

select * from store
join address
on address.address_id=store.address_id
join city
on city.city_id=address.city_id
join country
on country.country_id=city.country_id;

--20. List of stores that do not have inventory.

select * from store
left join inventory
on inventory.store_id=store.store_id
where inventory.store_id is null;

--21. List of customers who do not have movie rentals.

select * from customer
left join rental
on rental.customer_id=customer.customer_id
where rental.customer_id is null;

--22. List of Customers in India with address.

Select customer.customer_id, customer.first_name, customer.last_name, address.address, country.country
from customer
join address
on address.address_id=customer.address_id
join city
on city.city_id=address.city_id
join country
on country.country_id=city.country_id
where country.country='India';

--23. List of Customers with address all over the world.

Select customer.customer_id, customer.first_name, customer.last_name, address.address, country.country
from customer
join address
on address.address_id=customer.address_id
join city
on city.city_id=address.city_id
join country
on country.country_id=city.country_id;

--24. List of movies made in Japanese or Mandarin.

select * from film
join language
on language.language_id=film.language_id
where language.name='Japanese'

--25. List of languages with no movies.

select * from language
left join film
on film.language_id=language.language_id
where film.language_id is null;



