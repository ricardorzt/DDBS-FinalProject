#Insert Requests

#Objetos

INSERT INTO user_requests_object (
    requester_user_id,
    object_id,
    offered_object_id,
    offered_service_id,
    request_message,
    status,
    created_at,
    updated_at
)
SELECT
    CASE
        WHEN o.owner_user_id = 500 THEN 1
        ELSE o.owner_user_id + 1
        END AS requester_user_id,
    o.id,
    CASE
        WHEN o.id % 2 = 0 THEN ((o.id + 25 - 1) % 500) + 1
        ELSE NULL
        END AS offered_object_id,
    CASE
        WHEN o.id % 2 = 1 THEN ((o.id + 40 - 1) % 500) + 1
        ELSE NULL
        END AS offered_service_id,
    CONCAT('Solicitud sintética para el objeto ', o.id),
    CASE
        WHEN o.id % 7 = 0 THEN 'accepted'
        WHEN o.id % 11 = 0 THEN 'rejected'
        WHEN o.id % 13 = 0 THEN 'cancelled'
        ELSE 'pending'
        END AS status,
    DATE_ADD('2026-03-01 08:00:00', INTERVAL o.id MINUTE),
    DATE_ADD('2026-03-01 08:00:00', INTERVAL o.id MINUTE)
FROM objects o
WHERE o.id <= 500;

#Servicios

INSERT INTO user_requests_service (
    requester_user_id,
    service_id,
    offered_object_id,
    offered_service_id,
    request_message,
    status,
    created_at,
    updated_at
)
SELECT
    CASE
        WHEN s.provider_user_id >= 499 THEN s.provider_user_id - 2
        ELSE s.provider_user_id + 2
        END AS requester_user_id,
    s.id,
    CASE
        WHEN s.id % 2 = 0 THEN ((s.id + 60 - 1) % 500) + 1
        ELSE NULL
        END AS offered_object_id,
    CASE
        WHEN s.id % 2 = 1 THEN ((s.id + 80 - 1) % 500) + 1
        ELSE NULL
        END AS offered_service_id,
    CONCAT('Solicitud sintética para el servicio ', s.id),
    CASE
        WHEN s.id % 8 = 0 THEN 'accepted'
        WHEN s.id % 12 = 0 THEN 'rejected'
        WHEN s.id % 15 = 0 THEN 'cancelled'
        ELSE 'pending'
        END AS status,
    DATE_ADD('2026-03-02 09:00:00', INTERVAL s.id MINUTE),
    DATE_ADD('2026-03-02 09:00:00', INTERVAL s.id MINUTE)
FROM services s
WHERE s.id <= 500;


