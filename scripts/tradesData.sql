#Inserción de trueques

INSERT INTO trades (
    initiated_by_user_id,
    receiver_user_id,
    object_request_id,
    service_request_id,
    trade_type,
    status,
    meeting_address_id,
    agreed_at,
    completed_at,
    cancelled_at,
    created_at,
    updated_at
)
SELECT
    CASE
        WHEN n % 2 = 0 THEN uro.requester_user_id
        ELSE urs.requester_user_id
        END AS initiated_by_user_id,
    CASE
        WHEN n % 2 = 0 THEN o.owner_user_id
        ELSE s.provider_user_id
        END AS receiver_user_id,
    CASE WHEN n % 2 = 0 THEN uro.id ELSE NULL END AS object_request_id,
    CASE WHEN n % 2 = 1 THEN urs.id ELSE NULL END AS service_request_id,
    CASE
        WHEN n % 3 = 0 THEN 'mixed_exchange'
        WHEN n % 3 = 1 THEN 'object_exchange'
        ELSE 'service_exchange'
        END AS trade_type,
    CASE
        WHEN n % 9 = 0 THEN 'completed'
        WHEN n % 14 = 0 THEN 'cancelled'
        WHEN n % 5 = 0 THEN 'confirmed'
        ELSE 'in_progress'
        END AS status,
    ((n - 1) % 500) + 1 AS meeting_address_id,
    DATE_ADD('2026-03-05 10:00:00', INTERVAL n MINUTE),
    CASE WHEN n % 9 = 0 THEN DATE_ADD('2026-03-06 10:00:00', INTERVAL n MINUTE) ELSE NULL END,
    CASE WHEN n % 14 = 0 THEN DATE_ADD('2026-03-07 10:00:00', INTERVAL n MINUTE) ELSE NULL END,
    DATE_ADD('2026-03-05 10:00:00', INTERVAL n MINUTE),
    DATE_ADD('2026-03-05 10:00:00', INTERVAL n MINUTE)
FROM helper_seq hs
         LEFT JOIN user_requests_object uro ON uro.id = hs.n
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON urs.id = hs.n
         LEFT JOIN services s ON urs.service_id = s.id
WHERE hs.n <= 500;


