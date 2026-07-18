#1. Display all customer details who have made more than 5 payments.
SELECT *
FROM customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > 5
);

#2. Find the names of actors who have acted in more than 10 films.
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;

#Find the names of customers who never made a payment.
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
(
    SELECT DISTINCT customer_id
    FROM payment
);

#4. List all films whose rental rate is higher than the average rental rate of all films.
SELECT title, rental_rate
FROM film
WHERE rental_rate >
(
    SELECT AVG(rental_rate)
    FROM film
);

#5. List the titles of films that were never rented.
SELECT title
FROM film
WHERE film_id NOT IN
(
    SELECT DISTINCT inventory.film_id
    FROM rental
    JOIN inventory
    ON rental.inventory_id = inventory.inventory_id
);

#6. Display the customers who rented films in the same month as customer with ID 5.
WITH CustomerMonth AS
(
    SELECT DISTINCT MONTH(rental_date) AS rental_month
    FROM rental
    WHERE customer_id = 5
)

SELECT DISTINCT c.customer_id,
       c.first_name,
       c.last_name
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN CustomerMonth cm
ON MONTH(r.rental_date) = cm.rental_month;

#7. Find all staff members who handled a payment greater than the average payment amount. (CTE)
WITH AvgPayment AS
(
    SELECT AVG(amount) AS avg_amount
    FROM payment
)

SELECT DISTINCT s.staff_id,
       s.first_name,
       s.last_name
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
JOIN AvgPayment a
ON p.amount > a.avg_amount;

#8. Show the title and rental duration of films whose rental duration is greater than the average.
CREATE VIEW AboveAverageRental AS
SELECT title,
       rental_duration
FROM film
WHERE rental_duration >
(
    SELECT AVG(rental_duration)
    FROM film
);

SELECT *
FROM AboveAverageRental;

#9. Find all customers who have the same address as customer with ID
CREATE VIEW CustomerAddress AS
SELECT customer_id,
       first_name,
       last_name,
       address_id
FROM customer;

SELECT *
FROM CustomerAddress
WHERE address_id =
(
    SELECT address_id
    FROM customer
    WHERE customer_id = 1
);

#10. List all payments that are greater than the average of all payments.
CREATE TEMPORARY TABLE AvgPayment
AS
SELECT AVG(amount) AS avg_amount
FROM payment;

SELECT *
FROM payment
WHERE amount >
(
    SELECT avg_amount
    FROM AvgPayment
);


#Stored Procedure 1 – Customer Details with More Than 5 Payments
DROP PROCEDURE IF EXISTS GetCustomersMoreThanFivePayments;
DELIMITER //
CREATE PROCEDURE GetCustomersMoreThanFivePayments()
BEGIN
    SELECT *
    FROM customer
    WHERE customer_id IN
    (
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        HAVING COUNT(*) > 5
    );
END //
DELIMITER ;
CALL GetCustomersMoreThanFivePayments();

#2. Stored Procedure-Actors Who Have Acted in More Than 10 Films
DROP PROCEDURE IF EXISTS GetActorsMoreThanTenFilms;
DELIMITER //
CREATE PROCEDURE GetActorsMoreThanTenFilms()
BEGIN
    SELECT first_name, last_name
    FROM actor
    WHERE actor_id IN
    (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        HAVING COUNT(film_id) > 10
    );
END //
DELIMITER ;
CALL GetActorsMoreThanTenFilms();

#3.Stored Procedure - Customers Who Never Made a Payment
DROP PROCEDURE IF EXISTS GetCustomersWithoutPayments;
DELIMITER //
CREATE PROCEDURE GetCustomersWithoutPayments()
BEGIN
    SELECT first_name, last_name
    FROM customer
    WHERE customer_id NOT IN
    (
        SELECT DISTINCT customer_id
        FROM payment
    );
END //
DELIMITER ;
CALL GetCustomersWithoutPayments();

#4.Stored Procedure -Films Whose Rental Rate is Above Average
DROP PROCEDURE IF EXISTS GetAboveAverageRentalRateFilms;
DELIMITER //
CREATE PROCEDURE GetAboveAverageRentalRateFilms()
BEGIN
    SELECT title, rental_rate
    FROM film
    WHERE rental_rate >
    (
        SELECT AVG(rental_rate)
        FROM film
    );
END //
DELIMITER ;
CALL GetAboveAverageRentalRateFilms();

#5. Stored Procedure -Films That Were Never Rented
DROP PROCEDURE IF EXISTS GetFilmsNeverRented;
DELIMITER //
CREATE PROCEDURE GetFilmsNeverRented()
BEGIN
    SELECT title
    FROM film
    WHERE film_id NOT IN
    (
        SELECT DISTINCT i.film_id
        FROM rental r
        JOIN inventory i
        ON r.inventory_id = i.inventory_id
    );
END //
DELIMITER ;
CALL GetFilmsNeverRented();