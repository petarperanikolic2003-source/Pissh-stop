
INSERT INTO users (name, email, password_hash, role)
VALUES
    ('Test User', 'test@example.com', 'TEST_HASH', 'user');

INSERT INTO owners (name, contact_email, contact_phone)
VALUES
    ('Demo Cafe', 'demo@example.com', '0601234567');

INSERT INTO locations (
    owner_id, name, address, city, price_cents, is_open
)
SELECT
    o.id,
    'Demo Cafe WC',
    'Glavna 1',
    'Beograd',
    0,
    TRUE
FROM owners o
WHERE o.contact_email = 'demo@example.com';

INSERT INTO reviews (user_id, location_id, rating, comment)
SELECT
    u.id,
    l.id,
    5,
    'Test review for the demo location'
FROM users u
CROSS JOIN locations l
WHERE u.email = 'test@example.com'
  AND l.name = 'Demo Cafe WC'
  AND l.address = 'Glavna 1';

INSERT INTO usage_records (user_id, location_id)
SELECT u.id, l.id
FROM users u
CROSS JOIN locations l
WHERE u.email = 'test@example.com'
  AND l.name = 'Demo Cafe WC'
  AND l.address = 'Glavna 1';

INSERT INTO payments (user_id, location_id, amount_cents, status)
SELECT u.id, l.id, 0, 'completed'
FROM users u
CROSS JOIN locations l
WHERE u.email = 'test@example.com'
  AND l.name = 'Demo Cafe WC'
  AND l.address = 'Glavna 1';
