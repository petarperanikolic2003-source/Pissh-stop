SELECT * FROM locations;

SELECT name, address, city
FROM locations
WHERE is_open = TRUE;

SELECT *
FROM reviews
WHERE location_id = 1;

SELECT location_id, AVG(rating) AS average_rating
FROM reviews
GROUP BY location_id;
