#Inserción de etiquetas

#Objetos

INSERT INTO object_tags (
    object_id,
    tag_id,
    tagged_at
)
SELECT
    o.id,
    ((o.id - 1) % 500) + 1,
    DATE_ADD('2026-02-20 11:00:00', INTERVAL o.id MINUTE)
FROM objects o
WHERE o.id <= 500;

#Servicios

INSERT INTO service_tags (
    service_id,
    tag_id,
    tagged_at
)
SELECT
    s.id,
    ((s.id + 49) % 500) + 1,
    DATE_ADD('2026-02-20 12:00:00', INTERVAL s.id MINUTE)
FROM services s
WHERE s.id <= 500;
