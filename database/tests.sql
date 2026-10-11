
DO $$
BEGIN
    IF to_regclass('public.users') IS NULL
       OR to_regclass('public.owners') IS NULL
       OR to_regclass('public.locations') IS NULL
       OR to_regclass('public.reviews') IS NULL
       OR to_regclass('public.usage_records') IS NULL
       OR to_regclass('public.payments') IS NULL THEN
        RAISE EXCEPTION 'One or more required tables are missing';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM users
        WHERE email = 'test@example.com'
    ) THEN
        RAISE EXCEPTION 'Demo user was not found';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM locations
        WHERE name = 'Demo Cafe WC'
          AND address = 'Glavna 1'
    ) THEN
        RAISE EXCEPTION 'Demo location was not found';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM locations l
        JOIN owners o ON o.id = l.owner_id
        WHERE l.name = 'Demo Cafe WC'
          AND l.address = 'Glavna 1'
    ) THEN
        RAISE EXCEPTION 'Location-owner relationship is invalid';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM reviews r
        JOIN users u ON u.id = r.user_id
        JOIN locations l ON l.id = r.location_id
        WHERE u.email = 'test@example.com'
          AND l.name = 'Demo Cafe WC'
          AND r.rating = 5
    ) THEN
        RAISE EXCEPTION 'Demo review or its relationships are missing';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM usage_records ur
        JOIN users u ON u.id = ur.user_id
        JOIN locations l ON l.id = ur.location_id
        WHERE u.email = 'test@example.com'
          AND l.name = 'Demo Cafe WC'
    ) THEN
        RAISE EXCEPTION 'Demo usage record was not found';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM payments p
        JOIN users u ON u.id = p.user_id
        JOIN locations l ON l.id = p.location_id
        WHERE u.email = 'test@example.com'
          AND l.name = 'Demo Cafe WC'
          AND p.status = 'completed'
    ) THEN
        RAISE EXCEPTION 'Demo payment was not found';
    END IF;

    RAISE NOTICE 'All database tests passed successfully!';
END $$;
