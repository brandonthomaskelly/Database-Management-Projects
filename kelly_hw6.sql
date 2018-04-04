-- Brandon Kelly
-- CPSC 321 - 02
-- Homework #6
-- Description: Use the database that has been installed for the course to answer the
-- following questions. Within the cpsc321 DB database are a number of tables that have been created
-- and populated to represent simple movie rental data.


-- Q1: Find the total number of films by category ordered from most to least. Give the name of each
-- category
SELECT c.name, COUNT(*)
FROM film f, inventory i, film_category fc, category c
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND i.film_id = fc.film_id
GROUP BY c.category_id
ORDER BY COUNT(fc.category_id) desc;

-- Q2: Find the number of films acted in by each actor ordered from highest number of films to
-- lowest. For each actor, give their first and last name.

SELECT DISTINCT a.first_name, a.last_name, COUNT(*)
FROM actor a, film_actor fa, film f, inventory i
WHERE a.actor_id = fa.actor_id AND
fa.film_id = f.film_id AND
i.film_id = fa.film_id
GROUP BY a.actor_id
ORDER BY COUNT(*) desc;

--  Q3: For each ‘G’ rated film find the number of times it has been rented. The result should be
-- sorted from most rented to least rented.
SELECT f.title, COUNT(*)
FROM film f, rental r, inventory i
WHERE r.inventory_id = i.inventory_id AND
i.film_id = f.film_id AND
f.rating = 'G'
GROUP BY f.title
ORDER BY COUNT(*) desc;

-- Q4: Find all first and last names of customers that have rented at least ten ‘G’ rated films.
SELECT c.first_name, c.last_name, COUNT(*)
FROM customer c, rental r, film f, inventory i
WHERE f.rating = 'G' AND
c.customer_id = r.customer_id AND
i.inventory_id = r.inventory_id AND
i.film_id = f.film_id
GROUP BY c.customer_id
HAVING COUNT(*) >= 10
ORDER BY COUNT(*) desc;

-- Q5: Find the total sales (of payments) for each film category. Give the name of each category

SELECT c.name, SUM(p.amount)
FROM payment p
JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- Q6: Find the film (or films if there is a tie) that have been rented the most number of times.
-- You cannot use limit and your query must return only the film(s) rented the most number of
-- times (not the second, third, etc). Return the film id and title

SELECT t.title, MAX(most)
FROM (
	SELECT f.title, COUNT(*) as most
	FROM rental r
	JOIN inventory i USING (inventory_id)
	JOIN film f ON i.film_id = f.film_id
	GROUP BY f.title
	ORDER BY most desc
) as t;

--  Q7: Find the store (or stores) that have the most rentals. You cannot use limit and your query
-- must return only the store(s) that have the most rentals (not the second most, third most,
-- etc). Return the store id.
SELECT t2.store_id
FROM (
	SELECT MAX(most), t1.store_id
	FROM (
		SELECT s.store_id, COUNT(*) as most
		FROM rental r, inventory i, store s
		WHERE r.inventory_id = i.inventory_id
		AND s.store_id = i.store_id
		GROUP BY s.store_id
		ORDER BY most desc
	) as t1
) as t2;

-- Q8: Find the title of the most rented ‘G rated film(s).
SELECT t2.title
FROM(
	SELECT MAX(most), t1.title
		FROM(
		SELECT f.title, COUNT(*) as most
		FROM rental r
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film f ON f.film_id = i.film_id
		WHERE f.rating = 'G'
		GROUP BY f.title
		ORDER BY most desc
		) as t1
) as t2;

-- Q9: Find the total sales (of payments) for each store ordered from highest to lowest total sales.
SELECT i.store_id , SUM(p.amount)
FROM inventory i, payment p , rental r
WHERE p.rental_id = r.rental_id
AND i.inventory_id = r.inventory_id
GROUP BY i.store_id
ORDER BY SUM(p.amount) desc;

--  Q10: Find the movies + total number of times that they were rented to customers by a staff member.
SELECT f.title, t.last_name, t.first_name, COUNT(f.title)
FROM film f
	JOIN(
		SELECT rs.first_name, rs.last_name, i.film_id
		FROM inventory i
		JOIN(
			SELECT s.last_name, s.first_name, r.inventory_id
			FROM staff s
			JOIN rental r ON s.staff_id = r.staff_id
			) as rs ON i.inventory_id = rs.inventory_id
		) as t ON f.film_id = t.film_id
GROUP BY f.title, t.last_name
ORDER BY COUNT(f.title) desc;
