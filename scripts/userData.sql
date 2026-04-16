#Inserción de usuarios

#Se insertan cíclicamente

INSERT INTO users (
    permission_id,
    place_id,
    first_name,
    last_name,
    username,
    email,
    password_hash,
    phone,
    birth_date,
    profile_photo_url,
    bio,
    is_third_party_auth,
    third_party_provider,
    reputation_score,
    is_active,
    created_at,
    updated_at
)
SELECT
    CASE
        WHEN n % 20 = 0 THEN 3
        WHEN n % 10 = 0 THEN 2
        ELSE 1
        END AS permission_id,
    ((n - 1) % 18) + 1 AS place_id,
    CONCAT('Nombre', LPAD(n, 3, '0')),
    CONCAT('Apellido', LPAD(n, 3, '0')),
    CONCAT('usuario', LPAD(n, 3, '0')),
    CONCAT('usuario', LPAD(n, 3, '0'), '@barter.mx'),
    SHA2(CONCAT('Pass', n, '$2026'), 256),
    CONCAT('449', LPAD(n, 7, '0')),
    DATE_ADD('1990-01-01', INTERVAL (n % 10000) DAY),
    CONCAT('https://img.barter.mx/profiles/user_', n, '.jpg'),
    CONCAT('Perfil sintético del usuario ', n),
    CASE WHEN n % 7 = 0 THEN TRUE ELSE FALSE END,
    CASE
        WHEN n % 7 = 0 AND n % 2 = 0 THEN 'google'
        WHEN n % 7 = 0 THEN 'facebook'
        ELSE NULL
        END,
    ROUND((n % 50) * 0.10, 2),
    TRUE,
    DATE_ADD('2026-01-01 08:00:00', INTERVAL n HOUR),
    DATE_ADD('2026-01-01 08:00:00', INTERVAL n HOUR)
FROM helper_seq;

