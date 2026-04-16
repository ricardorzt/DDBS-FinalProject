#Inserción de ofertas

#Objetos

INSERT INTO objects (
    owner_user_id,
    place_id,
    title,
    description,
    category,
    estimated_value,
    status,
    condition_label,
    published_at,
    updated_at,
    is_active
)
SELECT
    u.id,
    u.place_id,
    CONCAT('Objeto ', LPAD(u.id, 4, '0')),
    CONCAT('Descripción sintética del objeto ', u.id),
    CASE
        WHEN u.id % 5 = 0 THEN 'Electrónica'
        WHEN u.id % 5 = 1 THEN 'Hogar'
        WHEN u.id % 5 = 2 THEN 'Herramientas'
        WHEN u.id % 5 = 3 THEN 'Ropa'
        ELSE 'Coleccionables'
        END,
    ROUND(100 + (u.id * 7.5), 2),
    CASE
        WHEN u.id % 9 = 0 THEN 'reserved'
        WHEN u.id % 13 = 0 THEN 'traded'
        ELSE 'available'
        END,
    CASE
        WHEN u.id % 4 = 0 THEN 'nuevo'
        WHEN u.id % 4 = 1 THEN 'seminuevo'
        WHEN u.id % 4 = 2 THEN 'usado'
        ELSE 'restaurado'
        END,
    DATE_ADD('2026-02-10 09:00:00', INTERVAL u.id MINUTE),
    DATE_ADD('2026-02-10 09:00:00', INTERVAL u.id MINUTE),
    TRUE
FROM users u
WHERE u.id <= 500;

#Servicios

INSERT INTO services (
    provider_user_id,
    place_id,
    title,
    description,
    category,
    estimated_value,
    status,
    modality,
    published_at,
    updated_at,
    is_active
)
SELECT
    u.id,
    u.place_id,
    CONCAT('Servicio ', LPAD(u.id, 4, '0')),
    CONCAT('Descripción sintética del servicio ', u.id),
    CASE
        WHEN u.id % 5 = 0 THEN 'Reparación'
        WHEN u.id % 5 = 1 THEN 'Clases'
        WHEN u.id % 5 = 2 THEN 'Transporte'
        WHEN u.id % 5 = 3 THEN 'Diseño'
        ELSE 'Mantenimiento'
        END,
    ROUND(150 + (u.id * 5.25), 2),
    CASE
        WHEN u.id % 11 = 0 THEN 'reserved'
        WHEN u.id % 17 = 0 THEN 'inactive'
        ELSE 'available'
        END,
    CASE
        WHEN u.id % 3 = 0 THEN 'presencial'
        WHEN u.id % 3 = 1 THEN 'remoto'
        ELSE 'mixto'
        END,
    DATE_ADD('2026-02-15 10:00:00', INTERVAL u.id MINUTE),
    DATE_ADD('2026-02-15 10:00:00', INTERVAL u.id MINUTE),
    TRUE
FROM users u
WHERE u.id <= 500;

