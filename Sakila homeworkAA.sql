
use sakila;

-- 1a. Display the first and last names of all actors from the table actor.

select 
	first_name, 
    last_name
from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters.
--     Name the column Actor Name.

select 
	concat(upper(first_name), ' ', upper(last_name)) AS fullname
from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only
--     the first name, "Joe." What is one query would you use to obtain this information?

select 
	actor_id,
    first_name,
    last_name 
from actor
where first_name ='Joe';

-- 2b. Find all actors whose last name contain the letters GEN:

select 
	actor_id, 
    first_name, 
    last_name 
from actor
where last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. 
--     This time, order the rows by last name and first name, in that order:

select 
	actor_id, 
    first_name, 
    last_name 
from actor
where last_name like '%li%' 
order by last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries:
--     Afghanistan, Bangladesh, and China:

select 
	country_id, 
    country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. 
--     You don't think you will be performing queries on a description,
--     so create a column in the table actor named description and use the data type BLOB 
--     (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).

alter table actor 
add column description blob after last_name;

select * from actor;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
--     Delete the description column.

alter table actor 
drop description;

select * from actor;

-- 4a. List the last names of actors, as well as how many actors have that last name.

select 
	count(*) as 'last name count', 
    last_name
from actor 
group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name,
--     but only for names that are shared by at least two actors

select 
	count(*) as 'last name count', 
    last_name
from actor 
group by last_name
having count(*) > 1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS.
--     Write a query to fix the record.

update actor 
set first_name ='Harpo' 
where first_name = 'GROUCHO' and last_name = 'Williams';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. 
--     It turns out that GROUCHO was the correct name after all!
--     In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.

update actor 
set first_name ='Groucho' 
where first_name = 'Harpo' and last_name = 'Williams';

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
--     Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html

show create table address

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member.
--     Use the tables staff and address:

select
	staff.first_name,
	staff.last_name,
	address.address,
	address.address2
from staff
left join address 	
	on staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005.
--     Use tables staff and payment.

select
	s.first_name,
    s.last_name, 
    sum(amount) as 'Purchases Processed by Staff'    
from payment p

join staff s
		on p.staff_id = s.staff_id
where 
	p.payment_date like '2005-08-%'
group by 
	s.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. 
--     Use tables film_actor and film. Use inner join.

select 
title, count(actor_id) as number_of_actors 
from film
join film_actor on film.film_id = film_actor.film_id
group by title

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

select 
	title, 
    (select count(*) from inventory where film.film_id = inventory.film_id ) as 'Number of Copies'
from film
where title = 'Hunchback Impossible';

-- 6e. Using the tables payment and customer and the JOIN command,
--     list the total paid by each customer.
--     List the customers alphabetically by last name:

select
	c.first_name,
	c.last_name,
	sum(p.amount) total_paid
from customer c
join payment p 
	on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name;

--     ![Total amount paid](Images/total_payment.png)

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
--     As an unintended consequence,films starting with the letters K and Q have also soared in popularity. 
--     Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

select 
	title 'English film titles starting with the letters K or Q'
from film
where (title like 'K%' or title like 'Q%') and title in(
	 select title
     from film f
     join language l 
		on f.language_id = l.language_id
     where name = 'english');  

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

select 
first_name, 
last_name
from actor
where actor_id in(        
	select 
	actor_id
	from film_actor
	where film_id in(    
		select 
		film_id
		from film
		where title = 'Alone Trip')); 


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names 
--     and email addresses of all Canadian customers. Use joins to retrieve this information.

select 
	first_name, 
    last_name, 
    email, 
    country
from customer c
join address a
	on c.address_id = a.address_id 
join city cy 
	on a.city_id = cy.city_id 
join country cty 
	on cy.country_id = cty.country_id
where country = 'canada';


-- 7d. Sales have been lagging among young families, and you wish to target all family  
--     movies for a promotion.Identify all movies categorized as family films.

select title, name
from film f

join film_category fc 
					on f.film_id = fc.film_id
join category c 
					on fc.category_id = c.category_id
        
where name = 'family' 


-- 7e. Display the most frequently rented movies in descending order.

select 
	count(*) as 'rental frequency', title
from film f

join inventory i 
		on f.film_id = i.film_id
join rental r 
		on i.inventory_id = r.inventory_id
        
group by title
order by count(*) desc;

-- 7f. Write a query to display how much business, in dollars, each store brought in.

select 
	concat(c.city,",", cy.country) as 'store',
    concat(m.first_name, ",",m.last_name) as 'manager',
    sum(p.amount) as 'total sales'
from payment p	

join rental r 
		on p.rental_id = r.rental_id
join inventory i 
		on r.inventory_id = i.inventory_id
join store s 
		on i.store_id = s.store_id
join address a 
		on s.address_id = a.address_id
join city c 
		on a.city_id = c.city_id
join country cy 	
		on c.country_id = cy.country_id
join staff m 
		on s.manager_staff_id = m.staff_id
        
group by s.store_id
order by cy.country, c.city;


-- 7g. Write a query to display for each store its store ID, city, and country.

select 
	store_id, 	
    city, 
    country
from store s

join address a 
		on s.address_id = a.address_id
join city c 
		on a.city_id = c.city_id
join country cty 
		on c.country_id = cty.country_id


-- 7h. List the top five genres in gross revenue in descending order.
--     (Hint: you may need to use the following tables:
--     category, film_category, inventory, payment, and rental.)

select 
	c.name, 
    sum(p.amount) as gross_rev
from payment p

join rental r 
			on p.rental_id = r.rental_id
join inventory i 
			on r.inventory_id = i.inventory_id
join film_category fc 
			on fc.film_id = i.film_id
join category c 
			on c.category_id = fc.category_id 
    
group by c.name
order by sum(p.amount) desc limit 5;
 


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the 
--     Top five genres by gross revenue. Use the solution from the problem above to create a view.
--     If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW Top_5_Genres_by_Revenue AS 
select 
	c.name, 
    sum(p.amount) as gross_rev
from payment p

join rental r 
			on p.rental_id = r.rental_id
join inventory i 
			on r.inventory_id = i.inventory_id
join film_category fc 
			on fc.film_id = i.film_id
join category c 
			on c.category_id = fc.category_id 
    
group by c.name
order by sum(p.amount) desc limit 5;

-- 8b. How would you display the view that you created in 8a?

select * from Top_5_Genres_by_Revenue;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

drop view Top_5_Genres_by_Revenue;

