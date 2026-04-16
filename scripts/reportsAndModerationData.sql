#Inserción de reportes y moderacion

INSERT INTO reports (
    reporter_user_id,
    reported_user_id,
    reported_object_id,
    reported_service_id,
    related_trade_id,
    reason,
    details,
    status,
    created_at,
    updated_at
)
SELECT
    ((n - 1) % 500) + 1 AS reporter_user_id,
    CASE WHEN n % 3 = 0 THEN ((n + 10 - 1) % 500) + 1 ELSE NULL END AS reported_user_id,
    CASE WHEN n % 3 = 1 THEN ((n + 20 - 1) % 500) + 1 ELSE NULL END AS reported_object_id,
    CASE WHEN n % 3 = 2 THEN ((n + 30 - 1) % 500) + 1 ELSE NULL END AS reported_service_id,
    ((n - 1) % 500) + 1 AS related_trade_id,
    CASE
        WHEN n % 4 = 0 THEN 'fraude'
        WHEN n % 4 = 1 THEN 'incumplimiento'
        WHEN n % 4 = 2 THEN 'contenido inapropiado'
        ELSE 'conducta sospechosa'
        END AS reason,
    CONCAT('Detalle sintético del reporte ', n),
    CASE
        WHEN n % 10 = 0 THEN 'closed'
        WHEN n % 6 = 0 THEN 'in_review'
        ELSE 'open'
        END AS status,
    DATE_ADD('2026-03-10 09:00:00', INTERVAL n MINUTE),
    DATE_ADD('2026-03-10 09:00:00', INTERVAL n MINUTE)
FROM helper_seq
WHERE n <= 500;

#Acciones de moderación

INSERT INTO moderation_actions (
    report_id,
    moderator_user_id,
    action_type,
    action_notes,
    created_at
)
SELECT
    r.id,
    CASE
        WHEN r.id % 10 = 0 THEN 10
        WHEN r.id % 5 = 0 THEN 20
        ELSE 30
        END AS moderator_user_id,
    CASE
        WHEN r.id % 5 = 0 THEN 'warning'
        WHEN r.id % 7 = 0 THEN 'remove_post'
        WHEN r.id % 9 = 0 THEN 'suspend_user'
        WHEN r.id % 10 = 0 THEN 'close_report'
        ELSE 'no_action'
        END AS action_type,
    CONCAT('Acción de moderación sintética para el reporte ', r.id),
    DATE_ADD('2026-03-12 11:00:00', INTERVAL r.id MINUTE)
FROM reports r
WHERE r.id <= 500;
