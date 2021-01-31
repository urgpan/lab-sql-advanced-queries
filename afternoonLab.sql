-- List each pair of actors that have worked together.

select f0.film_id,  f1.actor_id, f0.actor_id from film_actor as f0
join film_actor as f1
on f0.film_id = f1.film_id
and f0.actor_id <> f1.actor_id
group by f0.film_id;

#select f0.film_id,  f1.actor_id, f0.actor_id from film_actor as f0;

-- For each film, list actor that has acted in more films.
drop view if exists sakila.actor_film_rank;
create view sakila.actor_film_rank as
(
select
	actor_id, 
    count(film_id) as counter, 
    film_id,
    rank() over(partition by film_id order by count(film_id) desc) as ranking
from 
	film_actor 
group by 
	actor_id 
);
 
select distinct film_id, actor_id, counter  from sakila.actor_film_rank group by film_id order by counter;


