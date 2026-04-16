#Validación trueques, solicitudes, conversaciones y moderación

SELECT COUNT(*) AS total_user_requests_object FROM user_requests_object;
SELECT COUNT(*) AS total_user_requests_service FROM user_requests_service;
SELECT COUNT(*) AS total_trades FROM trades;
SELECT COUNT(*) AS total_conversations FROM conversations;
SELECT COUNT(*) AS total_conversation_participants FROM conversation_participants;
SELECT COUNT(*) AS total_messages FROM messages;
SELECT COUNT(*) AS total_reports FROM reports;
SELECT COUNT(*) AS total_moderation_actions FROM moderation_actions;

SELECT p.state, COUNT(*) AS total_requests_object
FROM user_requests_object uro
         JOIN objects o ON uro.object_id = o.id
         JOIN places p ON o.place_id = p.id
GROUP BY p.state
ORDER BY p.state;

SELECT p.state, COUNT(*) AS total_requests_service
FROM user_requests_service urs
         JOIN services s ON urs.service_id = s.id
         JOIN places p ON s.place_id = p.id
GROUP BY p.state
ORDER BY p.state;

SELECT p.state, COUNT(*) AS total_messages
FROM messages m
         JOIN conversations c ON m.conversation_id = c.id
         LEFT JOIN user_requests_object uro ON c.related_object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON c.related_service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
         JOIN places p ON p.id = COALESCE(p1.id, p2.id)
GROUP BY p.state
ORDER BY p.state;
