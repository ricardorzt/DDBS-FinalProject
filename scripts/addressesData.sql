#Inserción de direcciones

INSERT INTO addresses (
    user_id,
    place_id,
    street,
    ext_number,
    int_number,
    reference_text,
    address_type,
    is_primary,
    created_at,
    updated_at
)
SELECT
    u.id,
    u.place_id,
    CONCAT('Calle ', LPAD(u.id, 4, '0')),
    CAST((100 + (u.id % 400)) AS CHAR),
    CASE WHEN u.id % 5 = 0 THEN CAST((u.id % 20) + 1 AS CHAR) ELSE NULL END,
    CONCAT('Referencia del usuario ', u.id),
    CASE WHEN u.id % 4 = 0 THEN 'meeting_point' ELSE 'home' END,
    TRUE,
    DATE_ADD('2026-01-05 09:00:00', INTERVAL u.id MINUTE),
    DATE_ADD('2026-01-05 09:00:00', INTERVAL u.id MINUTE)
FROM users u;

