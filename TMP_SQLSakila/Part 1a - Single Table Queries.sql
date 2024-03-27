### TEAM MINI PROJECT: WRITING SQL QUERIES ###
## PART 1a: SINGLE TABLE QUERIES ##

#1. Get a list of all film �tles alphabetized by title. 
USE sakila;
SELECT title FROM film;

#2. Find the description, release year, length, and rating for the movie "KENTUCKIAN GIANT".
SELECT description, release_year, length, rating FROM film WHERE title = "KENTUCKIAN GIANT";

#3. Find the first name and last name of each employee (staff table). Your query should include the last name first, and then the first name. 
SELECT last_name, first_name FROM staff;

#4. Repeat the query above, but this time, the results should include only one column with the format last name, first name. The output column should be named "name".
SELECT CONCAT(last_name, ', ', first_name) AS name FROM staff;

#5. Get the number of customers. The output should be a single number. Name the column "num_customers". 
SELECT COUNT(customer_id) AS num_customers from customer;

#6. Get the number of customers who are active vs inactive in the system. 
SELECT COUNT(*) as "Number of Active" FROM customer WHERE active = 1;
SELECT COUNT(*) as "Number of Inactive" FROM customer WHERE active = 0;

#7. Get the average amount a customer spends on a rental. 
SELECT AVG(amount) from payment;

#8. Get the maximum amount any customer has spent on a rental.
SELECT MAX(amount) FROM payment;

#9. Get a list of actors. The results should include only one column with the format last name, first name. The column should be named "actor_name". The results should be sorted aphabetically by the last name (ascending). 
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor ORDER BY last_name ASC;

#10. Repeat this query above, but the results should be in reverse order.
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor ORDER BY last_name DESC;

#11. Repeat this query again, this time only get actors whose last names start with M or V, Order by last name ascending. 
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor 
WHERE last_name LIKE 'M%' or last_name LIKE "V%" ORDER BY last_name ASC;

#12. Repeat the query again, this time only get actors whose last names start with letters between M and V inclusive. Order the results aphabetically by last name (ascending). 
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor 
WHERE  last_name REGEXP '^[M-V]' ORDER BY last_name ASC;

#13. Get a list of each customer ID and the number of rentals they have in their history. Name this column "Number of Rentals". 
SELECT customer_id, COUNT(rental_id) as "Number of Rentals" FROM rental GROUP BY customer_id;

