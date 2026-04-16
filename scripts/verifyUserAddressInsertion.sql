#Verificaciones


SELECT COUNT(*) AS total_permissions FROM permissions;
SELECT COUNT(*) AS total_tags FROM tags;
SELECT COUNT(*) AS total_places FROM places;
SELECT COUNT(*) AS total_users FROM users;
SELECT COUNT(*) AS total_addresses FROM addresses;


SELECT p.state, COUNT(*) AS total_usuarios
FROM users u
         JOIN places p ON u.place_id = p.id
GROUP BY p.state
ORDER BY p.state;

SELECT p.state, p.city, COUNT(*) AS total_usuarios
FROM users u
         JOIN places p ON u.place_id = p.id
GROUP BY p.state, p.city
ORDER BY p.state, p.city;
