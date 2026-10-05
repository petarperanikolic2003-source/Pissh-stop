

INSERT INTO users (name, email, password_hash)
VALUES
('Test User', 'test@example.com', 'TEST_HASH');

INSERT INTO owners (name, contact_email)
VALUES
('Demo Cafe', 'demo@example.com');

INSERT INTO locations
(owner_id, name, address, city, price_cents)
VALUES
(1, 'Demo Cafe WC', 'Glavna 1', 'Beograd', 0);
