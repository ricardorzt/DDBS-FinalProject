#Inserción de media

INSERT INTO media (
    uploaded_by_user_id,
    media_type,
    file_url,
    mime_type,
    file_size_kb,
    created_at
)
SELECT
    u.id,
    CASE
        WHEN u.id % 4 = 0 THEN 'image'
        WHEN u.id % 4 = 1 THEN 'video'
        WHEN u.id % 4 = 2 THEN 'document'
        ELSE 'image'
        END,
    CONCAT('https://cdn.barter.mx/media/file_', u.id, '.bin'),
    CASE
        WHEN u.id % 4 = 0 THEN 'image/jpeg'
        WHEN u.id % 4 = 1 THEN 'video/mp4'
        WHEN u.id % 4 = 2 THEN 'application/pdf'
        ELSE 'image/png'
        END,
    100 + (u.id % 900),
    DATE_ADD('2026-02-22 08:00:00', INTERVAL u.id MINUTE)
FROM users u
WHERE u.id <= 500;

#Objetos

INSERT INTO object_media (
    object_id,
    media_id,
    is_primary,
    linked_at
)
SELECT
    o.id,
    o.id,
    TRUE,
    DATE_ADD('2026-02-23 09:00:00', INTERVAL o.id MINUTE)
FROM objects o
WHERE o.id <= 500;


#Servicios

INSERT INTO service_media (
    service_id,
    media_id,
    is_primary,
    linked_at
)
SELECT
    s.id,
    s.id,
    TRUE,
    DATE_ADD('2026-02-23 10:00:00', INTERVAL s.id MINUTE)
FROM services s
WHERE s.id <= 500;
