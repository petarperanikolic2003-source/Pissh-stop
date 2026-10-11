

SELECT *
FROM locations;


SELECT name, address, city, price_cents
FROM locations
WHERE is_open = TRUE;


SELECT
    l.name AS location_name,
    l.address,
    l.city,
    o.name AS owner_name
FROM locations l
LEFT JOIN owners o ON l.owner_id = o.id;


SELECT
    u.name AS user_name,
    l.name AS location_name,
    r.rating,
    r.comment,
    r.created_at
FROM reviews r
JOIN users u ON u.id = r.user_id
JOIN locations l ON l.id = r.location_id;


SELECT
    l.id,
    l.name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.id) AS total_reviews
FROM locations l
LEFT JOIN reviews r ON r.location_id = l.id
GROUP BY l.id, l.name
ORDER BY average_rating DESC NULLS LAST;


SELECT
    l.name,
    COUNT(ur.id) AS total_uses
FROM locations l
LEFT JOIN usage_records ur ON ur.location_id = l.id
GROUP BY l.id, l.name
ORDER BY total_uses DESC;


SELECT
    status,
    COUNT(*) AS payment_count,
    SUM(amount_cents) AS total_amount_cents
FROM payments
GROUP BY status;


SELECT
    u.name,
    l.name AS location_name,
    p.amount_cents,
    p.status,
    p.created_at
FROM payments p
JOIN users u ON u.id = p.user_id
JOIN locations l ON l.id = p.location_id
WHERE u.email = 'test@example.com'
ORDER BY p.created_at DESC;

SELECT l.id, l.name
FROM locations l
LEFT JOIN reviews r ON r.location_id = l.id
WHERE r.id IS NULL;


SELECT city, COUNT(*) AS location_count
FROM locations
GROUP BY city
ORDER BY location_count DESC;


