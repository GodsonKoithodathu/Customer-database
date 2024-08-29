-- query to get only those payments that have the highest amount per customer
SELECT *
FROM payment as e1
WHERE amount = (SELECT MAX (amount) 
				FROM payment as e2 
				WHERE e1.customer_id = e2.customer_id 
				GROUP BY customer_id )
ORDER BY customer_id;


-- query to get movie list that has the lowest replacement cost for each in rating category
SELECT title, film_id, replacement_cost, rating
FROM film as m1
WHERE replacement_cost = (SELECT MIN (replacement_cost) 
							FROM film AS m2 
							WHERE m1.rating = m2.rating);


-- query to get a movie list for those who have the highest length in each category
SELECT title, film_id, rating, length
FROM film as m1
WHERE length = (SELECT MAX (length) FROM film AS m2 WHERE m1.rating = m2.rating);


-- query to get all payments and the total payment amount of each customer and the total count of payments for each customer
SELECT payment_id, staff_id, customer_id, amount, 
	(SELECT SUM (amount) AS sum_of_amount FROM payment as m2 WHERE m1.customer_id = m2.customer_id),
	(SELECT COUNT (amount) AS payments_counts FROM payment as m3 WHERE m1.customer_id = m3.customer_id)
FROM payment as m1
ORDER BY customer_id, amount DESC;


-- query to get the highest replacement cost and the average of the replacement cost according to the ratings of each film
SELECT film_id, title, replacement_cost, rating, 
	(SELECT 
	ROUND (AVG (replacement_cost), 2) 
	FROM film AS f3 
	WHERE f1.rating = f3.rating)
FROM film AS f1
WHERE replacement_cost = (SELECT MAX (replacement_cost) 
							FROM film AS f2 
							WHERE f1.rating = f2.rating);


-- query to get only those payments who have the highest payment for each customer including their first name and payment_id
SELECT c1.first_name, p1.amount, p1.payment_id
FROM payment AS p1
INNER JOIN customer as c1
ON p1.customer_id = c1.customer_id
WHERE amount = (SELECT MAX (amount) FROM payment AS p2 WHERE p1.customer_id = p2.customer_id)



