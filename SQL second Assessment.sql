#Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
select first_name,last_name,email,count(*) AS duplicate_count
FROM customer
GROUP BY first_name,last_name,email
HAVING COUNT(*)>1

#Number of times letter 'a' is repeated in film descriptions
SELECT title, LENGTH(description) - LENGTH(REPLACE(description, 'a', '')) AS a_count
FROM film;

#Number of times each vowel is repeated in film descriptions
SELECT
    SUM(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'a', ''))) AS a_count,
    SUM(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'e', ''))) AS e_count,
    SUM(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'i', ''))) AS i_count,
    SUM(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'o', ''))) AS o_count,
    SUM(LENGTH(LOWER(description)) - LENGTH(REPLACE(LOWER(description), 'u', ''))) AS u_count
FROM film;

#Display the payments made by each customer
# Month wise
SELECT customer_id,MONTHNAME(payment_date) AS payment_month,SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id, MONTH(payment_date), MONTHNAME(payment_date)
ORDER BY customer_id, MONTH(payment_date);   
#year wise 
SELECT customer_id,YEAR(payment_date) AS payment_year,SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id, YEAR(payment_date)
ORDER BY customer_id, payment_year
#week wise
SELECT customer_id,WEEK(payment_date) AS payment_week,SUM(amount) AS total_payment
FROM payment
GROUP BY customer_id, WEEK(payment_date)
ORDER BY customer_id, payment_week

#Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
SELECT CASE
         WHEN DAY(LAST_DAY('2011-02-02')) = 29
         THEN 'Leap Year'
         ELSE 'Not a Leap Year'
       END AS result
       
#Display number of days remaining in the current year from today.
SELECT DATEDIFF(
           CONCAT(YEAR(CURDATE()), '-12-31'),
           CURDATE()
       ) AS days_remaining
       
#Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT payment_date,
       CASE
           WHEN MONTH(payment_date) BETWEEN 1 AND 3 THEN 'Q1'
           WHEN MONTH(payment_date) BETWEEN 4 AND 6 THEN 'Q2'
           WHEN MONTH(payment_date) BETWEEN 7 AND 9 THEN 'Q3'
           ELSE 'Q4'
       END AS quarter
FROM payment


