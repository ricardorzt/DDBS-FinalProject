#FRAGMENTATION VIEW CREATION

#Based on the minterm predicates defined in the documentation

USE barter_platform_db;

#Places

CREATE OR REPLACE VIEW vw_places_ags AS
SELECT *
FROM places
WHERE state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_places_jal AS
SELECT *
FROM places
WHERE state = 'Jalisco';

CREATE OR REPLACE VIEW vw_places_zac AS
SELECT *
FROM places
WHERE state = 'Zacatecas';

#Users

CREATE OR REPLACE VIEW vw_users_ags AS
SELECT u.*
FROM users u
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_users_jal AS
SELECT u.*
FROM users u
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_users_zac AS
SELECT u.*
FROM users u
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Zacatecas';

#Adressesses

CREATE OR REPLACE VIEW vw_addresses_ags AS
SELECT a.*
FROM addresses a
         JOIN places p ON a.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_addresses_jal AS
SELECT a.*
FROM addresses a
         JOIN places p ON a.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_addresses_zac AS
SELECT a.*
FROM addresses a
         JOIN places p ON a.place_id = p.id
WHERE p.state = 'Zacatecas';

#Objects

CREATE OR REPLACE VIEW vw_objects_ags AS
SELECT o.*
FROM objects o
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_objects_jal AS
SELECT o.*
FROM objects o
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_objects_zac AS
SELECT o.*
FROM objects o
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Zacatecas';

#Services

CREATE OR REPLACE VIEW vw_services_ags AS
SELECT s.*
FROM services s
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_services_jal AS
SELECT s.*
FROM services s
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_services_zac AS
SELECT s.*
FROM services s
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Zacatecas';

#Tags

CREATE OR REPLACE VIEW vw_object_tags_ags AS
SELECT ot.*
FROM object_tags ot
         JOIN objects o ON ot.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_object_tags_jal AS
SELECT ot.*
FROM object_tags ot
         JOIN objects o ON ot.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_object_tags_zac AS
SELECT ot.*
FROM object_tags ot
         JOIN objects o ON ot.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Zacatecas';


CREATE OR REPLACE VIEW vw_service_tags_ags AS
SELECT st.*
FROM service_tags st
         JOIN services s ON st.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_service_tags_jal AS
SELECT st.*
FROM service_tags st
         JOIN services s ON st.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_service_tags_zac AS
SELECT st.*
FROM service_tags st
         JOIN services s ON st.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Zacatecas';

#Media

CREATE OR REPLACE VIEW vw_media_ags AS
SELECT m.*
FROM media m
         JOIN users u ON m.uploaded_by_user_id = u.id
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_media_jal AS
SELECT m.*
FROM media m
         JOIN users u ON m.uploaded_by_user_id = u.id
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_media_zac AS
SELECT m.*
FROM media m
         JOIN users u ON m.uploaded_by_user_id = u.id
         JOIN places p ON u.place_id = p.id
WHERE p.state = 'Zacatecas';

#Object Media

CREATE OR REPLACE VIEW vw_object_media_ags AS
SELECT om.*
FROM object_media om
         JOIN objects o ON om.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_object_media_jal AS
SELECT om.*
FROM object_media om
         JOIN objects o ON om.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_object_media_zac AS
SELECT om.*
FROM object_media om
         JOIN objects o ON om.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Zacatecas';

#Service Media

CREATE OR REPLACE VIEW vw_service_media_ags AS
SELECT sm.*
FROM service_media sm
         JOIN services s ON sm.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_service_media_jal AS
SELECT sm.*
FROM service_media sm
         JOIN services s ON sm.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_service_media_zac AS
SELECT sm.*
FROM service_media sm
         JOIN services s ON sm.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Zacatecas';

#User request

CREATE OR REPLACE VIEW vw_user_requests_object_ags AS
SELECT uro.*
FROM user_requests_object uro
         JOIN objects o ON uro.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_user_requests_object_jal AS
SELECT uro.*
FROM user_requests_object uro
         JOIN objects o ON uro.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_user_requests_object_zac AS
SELECT uro.*
FROM user_requests_object uro
         JOIN objects o ON uro.object_id = o.id
         JOIN places p ON o.place_id = p.id
WHERE p.state = 'Zacatecas';


CREATE OR REPLACE VIEW vw_user_requests_service_ags AS
SELECT urs.*
FROM user_requests_service urs
         JOIN services s ON urs.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_user_requests_service_jal AS
SELECT urs.*
FROM user_requests_service urs
         JOIN services s ON urs.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Jalisco';

CREATE OR REPLACE VIEW vw_user_requests_service_zac AS
SELECT urs.*
FROM user_requests_service urs
         JOIN services s ON urs.service_id = s.id
         JOIN places p ON s.place_id = p.id
WHERE p.state = 'Zacatecas';

#Trades

CREATE OR REPLACE VIEW vw_trades_ags AS
SELECT t.*
FROM trades t
         LEFT JOIN user_requests_object uro ON t.object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON t.service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_trades_jal AS
SELECT t.*
FROM trades t
         LEFT JOIN user_requests_object uro ON t.object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON t.service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Jalisco';

CREATE OR REPLACE VIEW vw_trades_zac AS
SELECT t.*
FROM trades t
         LEFT JOIN user_requests_object uro ON t.object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON t.service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Zacatecas';

#Convos

CREATE OR REPLACE VIEW vw_conversations_ags AS
SELECT c.*
FROM conversations c
         LEFT JOIN user_requests_object uro ON c.related_object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON c.related_service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_conversations_jal AS
SELECT c.*
FROM conversations c
         LEFT JOIN user_requests_object uro ON c.related_object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON c.related_service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Jalisco';

CREATE OR REPLACE VIEW vw_conversations_zac AS
SELECT c.*
FROM conversations c
         LEFT JOIN user_requests_object uro ON c.related_object_request_id = uro.id
         LEFT JOIN objects o ON uro.object_id = o.id
         LEFT JOIN user_requests_service urs ON c.related_service_request_id = urs.id
         LEFT JOIN services s ON urs.service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
WHERE COALESCE(p1.state, p2.state) = 'Zacatecas';


CREATE OR REPLACE VIEW vw_conversation_participants_ags AS
SELECT cp.*
FROM conversation_participants cp
         JOIN vw_conversations_ags vc ON cp.conversation_id = vc.id;

CREATE OR REPLACE VIEW vw_conversation_participants_jal AS
SELECT cp.*
FROM conversation_participants cp
         JOIN vw_conversations_jal vc ON cp.conversation_id = vc.id;

CREATE OR REPLACE VIEW vw_conversation_participants_zac AS
SELECT cp.*
FROM conversation_participants cp
         JOIN vw_conversations_zac vc ON cp.conversation_id = vc.id;

#Messages

CREATE OR REPLACE VIEW vw_messages_ags AS
SELECT m.*
FROM messages m
         JOIN vw_conversations_ags vc ON m.conversation_id = vc.id;

CREATE OR REPLACE VIEW vw_messages_jal AS
SELECT m.*
FROM messages m
         JOIN vw_conversations_jal vc ON m.conversation_id = vc.id;

CREATE OR REPLACE VIEW vw_messages_zac AS
SELECT m.*
FROM messages m
         JOIN vw_conversations_zac vc ON m.conversation_id = vc.id;

#Reports

CREATE OR REPLACE VIEW vw_reports_ags AS
SELECT r.*
FROM reports r
         LEFT JOIN objects o ON r.reported_object_id = o.id
         LEFT JOIN services s ON r.reported_service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
         LEFT JOIN users u ON r.reporter_user_id = u.id
         LEFT JOIN places p3 ON u.place_id = p3.id
WHERE COALESCE(p1.state, p2.state, p3.state) = 'Aguascalientes';

CREATE OR REPLACE VIEW vw_reports_jal AS
SELECT r.*
FROM reports r
         LEFT JOIN objects o ON r.reported_object_id = o.id
         LEFT JOIN services s ON r.reported_service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
         LEFT JOIN users u ON r.reporter_user_id = u.id
         LEFT JOIN places p3 ON u.place_id = p3.id
WHERE COALESCE(p1.state, p2.state, p3.state) = 'Jalisco';

CREATE OR REPLACE VIEW vw_reports_zac AS
SELECT r.*
FROM reports r
         LEFT JOIN objects o ON r.reported_object_id = o.id
         LEFT JOIN services s ON r.reported_service_id = s.id
         LEFT JOIN places p1 ON o.place_id = p1.id
         LEFT JOIN places p2 ON s.place_id = p2.id
         LEFT JOIN users u ON r.reporter_user_id = u.id
         LEFT JOIN places p3 ON u.place_id = p3.id
WHERE COALESCE(p1.state, p2.state, p3.state) = 'Zacatecas';

#Mod actions

CREATE OR REPLACE VIEW vw_moderation_actions_ags AS
SELECT ma.*
FROM moderation_actions ma
         JOIN vw_reports_ags vr ON ma.report_id = vr.id;

CREATE OR REPLACE VIEW vw_moderation_actions_jal AS
SELECT ma.*
FROM moderation_actions ma
         JOIN vw_reports_jal vr ON ma.report_id = vr.id;

CREATE OR REPLACE VIEW vw_moderation_actions_zac AS
SELECT ma.*
FROM moderation_actions ma
         JOIN vw_reports_zac vr ON ma.report_id = vr.id;

#Creation verification

SHOW FULL TABLES IN barter_platform_db WHERE TABLE_TYPE = 'VIEW';