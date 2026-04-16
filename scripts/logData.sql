#Inserción de logs

INSERT INTO logs (
    user_id,
    event_type,
    event_description,
    ip_address,
    device_info,
    created_at
)
SELECT
    ((n - 1) % 500) + 1,
    CASE
        WHEN n % 5 = 0 THEN 'login'
        WHEN n % 5 = 1 THEN 'publish_object'
        WHEN n % 5 = 2 THEN 'publish_service'
        WHEN n % 5 = 3 THEN 'send_message'
        ELSE 'update_profile'
        END,
    CONCAT('Evento sintético número ', n),
    CONCAT('192.168.1.', (n % 254) + 1),
    CASE
        WHEN n % 3 = 0 THEN 'Android'
        WHEN n % 3 = 1 THEN 'iPhone'
        ELSE 'Web Browser'
        END,
    DATE_ADD('2026-02-01 08:00:00', INTERVAL n MINUTE)
FROM helper_seq;
