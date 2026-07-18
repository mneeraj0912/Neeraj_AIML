#1. List all customers along with the films they have rented.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       f.title
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN film f
ON i.film_id = f.film_id;

#2. List all customers and show their rental count, including those who haven't rented any films.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name;
         
#3. Show all films along with their category. Include films that don't have a category assigned.
SELECT f.title,
       c.name AS category
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id;

#4. Show all customers and staff emails from both customer and staff tables using a FULL OUTER JOIN (simulate using LEFT + RIGHT + UNION).
SELECT c.first_name AS customer_name,
       c.email AS customer_email,
       s.first_name AS staff_name,
       s.email AS staff_email
FROM customer c
LEFT JOIN staff s
ON c.store_id = s.store_id

UNION

SELECT c.first_name AS customer_name,
       c.email AS customer_email,
       s.first_name AS staff_name,
       s.email AS staff_email
FROM customer c
RIGHT JOIN staff s
ON c.store_id = s.store_id;

#5. Find all actors who acted in the film "ACADEMY DINOSAUR".
SELECT a.actor_id,
       a.first_name,
       a.last_name
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR';

#6. List all stores and the total number of staff members working in each store, even if a store has no staff.
SELECT s.store_id,
       COUNT(st.staff_id) AS total_staff
FROM store s
LEFT JOIN staff st
ON s.store_id = st.store_id
GROUP BY s.store_id;

#7. List the customers who have rented films more than 5 times. Include their name and total rental count.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING COUNT(r.rental_id) > 5;