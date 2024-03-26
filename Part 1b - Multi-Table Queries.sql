### TEAM MINI PROJECT: WRITING SQL QUERIES ###
## PART 1b: MULTI-TABLE QUERIES ##

#1. Get a list of category names and a count of movies that fall into that category. Name the category column “category” the count column “num_films”. Order the results alphabetically (ascending). Use the WHERE clause to join the tables. 
SELECT c.name AS category, COUNT(fc.film_id) AS num_films
FROM film_category fc, category c
WHERE fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name ASC;

#2. Repeat the query above using a JOIN clause instead of the WHERE clause. 
SELECT c.name AS category, COUNT(fc.film_id) AS num_films
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name ASC;

#3. Get a list of country names and a count of the cities that are in that country. Name the count column “num_cities”. Order the results alphabe�cally (ascending). Use the WHERE clause to join the tables. 
SELECT co.country, COUNT(ci.city_id) AS num_cities
FROM city ci, country co
WHERE ci.country_id = co.country_id
GROUP BY co.country
ORDER BY co.country ASC;

#4. Repeat the query above using a JOIN clause instead of the WHERE clause. 
SELECT co.country, COUNT(ci.city_id) AS num_cities
FROM city ci
JOIN country co on ci.country_id = co.country_id
GROUP BY co.country
ORDER BY co.country ASC;

#5. Get a list of each customer’s last name and first name and the number of rentals they have. Name the count column “num_rentals”. Order the result by the number of rentals in descending order. The highest number of rentals should be at the top. Sort any �es (same number of rentals) by last name (ascending). Use the WHERE clause to join the tables. 
SELECT cu.last_name, cu.first_name, COUNT(r.rental_id) as num_rentals
FROM customer cu, rental r
WHERE cu.customer_id = r.customer_id
GROUP BY cu.last_name, cu.first_name
ORDER BY num_rentals DESC, cu.last_name ASC;

#6. Repeat the query above using a JOIN clause instead of the WHERE clause.
SELECT cu.last_name, cu.first_name, COUNT(r.rental_id) AS num_rentals
FROM rental r
JOIN customer cu ON cu.customer_id = r.customer_id
GROUP BY cu.last_name, cu.first_name
ORDER BY num_rentals DESC, cu.last_name ASC;

#7. Get a list of each customer’s last name and first name and the amount of money they have spent on rentals. Name the sum column “total_spent”. Order the result by the amount in descending order. The highest amount of money spent should be at the top. Sort any �es (amount of money spent) by last name (ascending). Use the JOIN clause for this query. 
SELECT cu.last_name, cu.first_name, SUM(p.amount) AS total_spent
FROM payment p 
JOIN customer cu on cu.customer_id = p.customer_id
GROUP BY cu.last_name, cu.first_name
ORDER BY total_spent DESC, cu.last_name ASC;

#8. Get the number of actors in each film. Order the results (ascending) by the film �tle and name the column with the actor count “num_actors”. 
SELECT f.title, SUM(fa.actor_id) as num_actors
FROM film f, film_actor fa
WHERE f.film_id = fa.film_id
GROUP BY f.title
ORDER BY f.title ASC;

#9. Get the number of films each manager holds.  Use only the manager staff id to iden�fy the manager.  Name the column with the number of films “num_films”. 
SELECT s.manager_staff_id, SUM(i.film_id) AS num_films
FROM store s, inventory i
WHERE s.store_id = i.store_id
GROUP BY s.manager_staff_id;

#10. Get the number of customers per manager. Use only the manager staff id to iden�fy the manager.  Name the column with the number of films “num_customers”. Order by store id (ascending).  
SELECT s.manager_staff_id, SUM(c.customer_id) AS num_customers
FROM store s, customer c
WHERE s.store_id = c.store_id
GROUP BY s.manager_staff_id
ORDER BY c.store_id ASC;

#11. Get the title and film category of each film. Order the results by category name. Rename the “name” column so it says “category”. This query will involve joining three tables using the JOIN syntax. 
SELECT f.title, c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY category ASC;

#12. Get a list of each customer’s first and last name (individually, not concatenated) and their full address including city and country.  Order the results by the customer’s last name. This will involve joining four tables using the JOIN syntax. 
SELECT c.first_name, c.last_name, CONCAT(a.address, ' ',ci.city, ', ', co.country) AS address
FROM address a
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN customer c ON c.address_id = a.address_id
ORDER BY c.last_name ASC;

#13. Repeat the query above except this time include only inac�ve customers from China. 
SELECT c.first_name, c.last_name, CONCAT(a.address, ' ',ci.city, ', ', co.country) AS address
FROM address a
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN customer c ON c.address_id = a.address_id
WHERE co.country = "China"
ORDER BY c.last_name ASC;

#14. Get a list of the titles of every film each customer has rented. Order the results by customer last name (ascending) and title (ascending). 
SELECT f.title, c.last_name, c.first_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r on i.inventory_id = r.inventory_id
JOIN customer c on r.customer_id = c.customer_id
GROUP BY c.last_name, c.first_name, f.title
ORDER BY c.last_name ASC, f.title ASC;

#15. Repeat the query above, but this time, include the category of each �tle in the results. Name the category column “category”.  Order the results by the same columns (name and �tle). 
SELECT f.title, c.last_name, c.first_name, ca.name AS category
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category ca ON fc.category_id = ca.category_id
GROUP BY c.last_name, c.first_name, f.title, category
ORDER BY c.last_name ASC, f.title ASC;

#16. Get a list of each customer that includes their first and last name, the number of rentals  (num_rentals) they have had and the total amount (total_spent) of money they have spent on rentals. Order the results by last name (ascending). 
SELECT cu.first_name, cu.last_name, COUNT(r.rental_id) AS num_rentals, SUM(p.amount) AS total_spent
FROM rental r
JOIN customer cu ON cu.customer_id = r.customer_id
JOIN payment p ON cu.customer_id = p.customer_id
GROUP BY cu.last_name, cu.first_name
ORDER BY cu.last_name ASC;

#17. Repeat the query above, but this �me add the customer’s country to the output. The order of the columns should be last_name, first_name, country, num_rentals, total_spent.  Order rows by last name (ascending)
SELECT cu.first_name, cu.last_name, COUNT(r.rental_id) AS num_rentals, SUM(p.amount) AS total_spent, co.country
FROM rental r
JOIN customer cu ON cu.customer_id = r.customer_id
JOIN payment p ON cu.customer_id = p.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY cu.last_name, cu.first_name, co.country
ORDER BY cu.last_name ASC;