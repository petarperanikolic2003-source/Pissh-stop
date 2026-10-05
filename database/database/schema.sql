CREATE TABLE users (
    id PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact_email VARCHAR(150),
    contact_phone VARCHAR(30)
);

CREATE TABLE locations (
    id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT REFERENCES owners(id),
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    price_cents INTEGER DEFAULT 0,
    is_open BOOLEAN DEFAULT TRUE
);

CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    location_id BIGINT REFERENCES locations(id),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usage_records (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    location_id BIGINT REFERENCES locations(id),
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    location_id BIGINT REFERENCES locations(id),
    amount_cents INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
