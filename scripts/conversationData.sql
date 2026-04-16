#Inserción de conversaciones

INSERT INTO conversations (
    created_by_user_id,
    related_object_request_id,
    related_service_request_id,
    created_at,
    updated_at,
    is_active
)
SELECT
    CASE
        WHEN n % 2 = 0 THEN uro.requester_user_id
        ELSE urs.requester_user_id
        END AS created_by_user_id,
    CASE WHEN n % 2 = 0 THEN uro.id ELSE NULL END,
    CASE WHEN n % 2 = 1 THEN urs.id ELSE NULL END,
    DATE_ADD('2026-03-08 08:00:00', INTERVAL n MINUTE),
    DATE_ADD('2026-03-08 08:00:00', INTERVAL n MINUTE),
    TRUE
FROM helper_seq hs
         LEFT JOIN user_requests_object uro ON uro.id = hs.n
         LEFT JOIN user_requests_service urs ON urs.id = hs.n
WHERE hs.n <= 500;

#Participantes

INSERT INTO conversation_participants (
    conversation_id,
    user_id,
    joined_at,
    last_read_at
)
SELECT
    c.id,
    c.created_by_user_id,
    c.created_at,
    DATE_ADD(c.created_at, INTERVAL 5 MINUTE)
FROM conversations c;

INSERT INTO conversation_participants (
    conversation_id,
    user_id,
    joined_at,
    last_read_at
)
SELECT
    c.id,
    CASE
        WHEN c.related_object_request_id IS NOT NULL THEN o.owner_user_id
        ELSE s.provider_user_id
        END AS user_id,
    c.created_at,
    DATE_ADD(c.created_at, INTERVAL 7 MINUTE)
FROM conversations c
         LEFT JOIN user_requests_object uro ON c.related_object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON c.related_service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id;


#Messages

INSERT INTO messages (
    conversation_id,
    sender_user_id,
    message_text,
    sent_at,
    read_at,
    is_deleted
)
SELECT
    c.id,
    c.created_by_user_id,
    CONCAT('Mensaje sintético inicial de la conversación ', c.id),
    DATE_ADD(c.created_at, INTERVAL 2 MINUTE),
    DATE_ADD(c.created_at, INTERVAL 6 MINUTE),
    FALSE
FROM conversations c
WHERE c.id <= 500;

