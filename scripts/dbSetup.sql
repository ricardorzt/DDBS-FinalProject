#DATABASE SET UP
#Creación de la base de datos y usuario

CREATE DATABASE barter_platform_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

CREATE USER 'barter_admin'@'%' IDENTIFIED BY 'Barter2026$Seguro!';
GRANT ALL PRIVILEGES ON barter_platform_db.* TO 'barter_admin'@'%';

CREATE USER 'barter_admin'@'localhost' IDENTIFIED BY 'Barter2026$Seguro!';
GRANT ALL PRIVILEGES ON barter_platform_db.* TO 'barter_admin'@'localhost';

FLUSH PRIVILEGES;

USE barter_platform_db;

#Visualización de tablas

SHOW DATABASES;
SHOW GRANTS FOR 'barter_admin'@'%';
SHOW GRANTS FOR 'barter_admin'@'localhost';
