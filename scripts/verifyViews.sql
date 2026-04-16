#Validacióm de Vistas de Fragmentación

SELECT COUNT(*) AS total_vw_users_ags FROM vw_users_ags;
SELECT COUNT(*) AS total_vw_users_jal FROM vw_users_jal;
SELECT COUNT(*) AS total_vw_users_zac FROM vw_users_zac;

SELECT COUNT(*) AS total_vw_objects_ags FROM vw_objects_ags;
SELECT COUNT(*) AS total_vw_objects_jal FROM vw_objects_jal;
SELECT COUNT(*) AS total_vw_objects_zac FROM vw_objects_zac;

SELECT COUNT(*) AS total_vw_services_ags FROM vw_services_ags;
SELECT COUNT(*) AS total_vw_services_jal FROM vw_services_jal;
SELECT COUNT(*) AS total_vw_services_zac FROM vw_services_zac;

SELECT COUNT(*) AS total_vw_messages_ags FROM vw_messages_ags;
SELECT COUNT(*) AS total_vw_messages_jal FROM vw_messages_jal;
SELECT COUNT(*) AS total_vw_messages_zac FROM vw_messages_zac;

SELECT COUNT(*) AS total_vw_reports_ags FROM vw_reports_ags;
SELECT COUNT(*) AS total_vw_reports_jal FROM vw_reports_jal;
SELECT COUNT(*) AS total_vw_reports_zac FROM vw_reports_zac;

#Individual

SELECT * FROM vw_users_ags LIMIT 10;
SELECT * FROM vw_objects_jal LIMIT 10;
SELECT * FROM vw_services_zac LIMIT 10;
SELECT * FROM vw_messages_ags LIMIT 10;
SELECT * FROM vw_reports_jal LIMIT 10;

#Correctness

SELECT
    (SELECT COUNT(*) FROM users) AS total_users,
    (
        (SELECT COUNT(*) FROM vw_users_ags) +
        (SELECT COUNT(*) FROM vw_users_jal) +
        (SELECT COUNT(*) FROM vw_users_zac)
        ) AS total_fragmentado_users;

SELECT
    (SELECT COUNT(*) FROM objects) AS total_objects,
    (
        (SELECT COUNT(*) FROM vw_objects_ags) +
        (SELECT COUNT(*) FROM vw_objects_jal) +
        (SELECT COUNT(*) FROM vw_objects_zac)
        ) AS total_fragmentado_objects;
SELECT
    (SELECT COUNT(*) FROM services) AS total_services,
    (
        (SELECT COUNT(*) FROM vw_services_ags) +
        (SELECT COUNT(*) FROM vw_services_jal) +
        (SELECT COUNT(*) FROM vw_services_zac)
        ) AS total_fragmentado_services;

