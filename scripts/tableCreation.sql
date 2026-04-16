#TABLE CREATION

USE barter_platform_db;

#ENGINE specification is optional

CREATE TABLE permissions (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             name VARCHAR(50) NOT NULL UNIQUE,
                             description VARCHAR(255),
                             created_at DATETIME NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tags (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(80) NOT NULL UNIQUE,
                      description VARCHAR(255),
                      created_at DATETIME NOT NULL
) ENGINE=InnoDB;

CREATE TABLE places (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        country VARCHAR(80) NOT NULL,
                        state VARCHAR(80) NOT NULL,
                        city VARCHAR(80) NOT NULL,
                        postal_code VARCHAR(12),
                        neighborhood VARCHAR(120),
                        latitude DECIMAL(10,7),
                        longitude DECIMAL(10,7),
                        created_at DATETIME NOT NULL,
                        INDEX idx_places_state (state),
                        INDEX idx_places_city (city),
                        INDEX idx_places_region (country, state, city)
) ENGINE=InnoDB;

CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       permission_id INT NOT NULL,
                       place_id INT NOT NULL,
                       first_name VARCHAR(80) NOT NULL,
                       last_name VARCHAR(80) NOT NULL,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(120) NOT NULL UNIQUE,
                       password_hash VARCHAR(255),
                       phone VARCHAR(20),
                       birth_date DATE,
                       profile_photo_url VARCHAR(255),
                       bio TEXT,
                       is_third_party_auth BOOLEAN NOT NULL DEFAULT FALSE,
                       third_party_provider VARCHAR(50),
                       reputation_score DECIMAL(5,2) NOT NULL DEFAULT 0,
                       is_active BOOLEAN NOT NULL DEFAULT TRUE,
                       created_at DATETIME NOT NULL,
                       updated_at DATETIME NOT NULL,
                       INDEX idx_users_permission (permission_id),
                       INDEX idx_users_place (place_id),
                       INDEX idx_users_active (is_active),
                       CONSTRAINT fk_users_permission FOREIGN KEY (permission_id) REFERENCES permissions(id),
                       CONSTRAINT fk_users_place FOREIGN KEY (place_id) REFERENCES places(id)
) ENGINE=InnoDB;

CREATE TABLE addresses (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           user_id BIGINT NOT NULL,
                           place_id INT NOT NULL,
                           street VARCHAR(120) NOT NULL,
                           ext_number VARCHAR(20),
                           int_number VARCHAR(20),
                           reference_text VARCHAR(255),
                           address_type VARCHAR(30) NOT NULL,
                           is_primary BOOLEAN NOT NULL DEFAULT FALSE,
                           created_at DATETIME NOT NULL,
                           updated_at DATETIME NOT NULL,
                           INDEX idx_addresses_user (user_id),
                           INDEX idx_addresses_place (place_id),
                           INDEX idx_addresses_primary (is_primary),
                           CONSTRAINT fk_addresses_user FOREIGN KEY (user_id) REFERENCES users(id),
                           CONSTRAINT fk_addresses_place FOREIGN KEY (place_id) REFERENCES places(id)
) ENGINE=InnoDB;

CREATE TABLE logs (
                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                      user_id BIGINT NULL,
                      event_type VARCHAR(80) NOT NULL,
                      event_description TEXT,
                      ip_address VARCHAR(45),
                      device_info VARCHAR(255),
                      created_at DATETIME NOT NULL,
                      INDEX idx_logs_user (user_id),
                      INDEX idx_logs_event_type (event_type),
                      INDEX idx_logs_created_at (created_at),
                      CONSTRAINT fk_logs_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE objects (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         owner_user_id BIGINT NOT NULL,
                         place_id INT NOT NULL,
                         title VARCHAR(120) NOT NULL,
                         description TEXT NOT NULL,
                         category VARCHAR(80),
                         estimated_value DECIMAL(12,2),
                         status VARCHAR(30) NOT NULL DEFAULT 'available',
                         condition_label VARCHAR(50),
                         published_at DATETIME NOT NULL,
                         updated_at DATETIME NOT NULL,
                         is_active BOOLEAN NOT NULL DEFAULT TRUE,
                         INDEX idx_objects_owner (owner_user_id),
                         INDEX idx_objects_place (place_id),
                         INDEX idx_objects_status (status),
                         INDEX idx_objects_active (is_active),
                         INDEX idx_objects_published (published_at),
                         CONSTRAINT fk_objects_owner FOREIGN KEY (owner_user_id) REFERENCES users(id),
                         CONSTRAINT fk_objects_place FOREIGN KEY (place_id) REFERENCES places(id)
) ENGINE=InnoDB;

CREATE TABLE services (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          provider_user_id BIGINT NOT NULL,
                          place_id INT NOT NULL,
                          title VARCHAR(120) NOT NULL,
                          description TEXT NOT NULL,
                          category VARCHAR(80),
                          estimated_value DECIMAL(12,2),
                          status VARCHAR(30) NOT NULL DEFAULT 'available',
                          modality VARCHAR(30),
                          published_at DATETIME NOT NULL,
                          updated_at DATETIME NOT NULL,
                          is_active BOOLEAN NOT NULL DEFAULT TRUE,
                          INDEX idx_services_provider (provider_user_id),
                          INDEX idx_services_place (place_id),
                          INDEX idx_services_status (status),
                          INDEX idx_services_active (is_active),
                          INDEX idx_services_published (published_at),
                          CONSTRAINT fk_services_provider FOREIGN KEY (provider_user_id) REFERENCES users(id),
                          CONSTRAINT fk_services_place FOREIGN KEY (place_id) REFERENCES places(id)
) ENGINE=InnoDB;

CREATE TABLE object_tags (
                             object_id BIGINT NOT NULL,
                             tag_id INT NOT NULL,
                             tagged_at DATETIME NOT NULL,
                             PRIMARY KEY (object_id, tag_id),
                             INDEX idx_object_tags_tag (tag_id),
                             CONSTRAINT fk_object_tags_object FOREIGN KEY (object_id) REFERENCES objects(id),
                             CONSTRAINT fk_object_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(id)
) ENGINE=InnoDB;

CREATE TABLE service_tags (
                              service_id BIGINT NOT NULL,
                              tag_id INT NOT NULL,
                              tagged_at DATETIME NOT NULL,
                              PRIMARY KEY (service_id, tag_id),
                              INDEX idx_service_tags_tag (tag_id),
                              CONSTRAINT fk_service_tags_service FOREIGN KEY (service_id) REFERENCES services(id),
                              CONSTRAINT fk_service_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(id)
) ENGINE=InnoDB;

CREATE TABLE media (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       uploaded_by_user_id BIGINT NOT NULL,
                       media_type VARCHAR(30) NOT NULL,
                       file_url VARCHAR(255) NOT NULL,
                       mime_type VARCHAR(80),
                       file_size_kb INT,
                       created_at DATETIME NOT NULL,
                       INDEX idx_media_user (uploaded_by_user_id),
                       INDEX idx_media_type (media_type),
                       CONSTRAINT fk_media_user FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE object_media (
                              object_id BIGINT NOT NULL,
                              media_id BIGINT NOT NULL,
                              is_primary BOOLEAN NOT NULL DEFAULT FALSE,
                              linked_at DATETIME NOT NULL,
                              PRIMARY KEY (object_id, media_id),
                              INDEX idx_object_media_media (media_id),
                              CONSTRAINT fk_object_media_object FOREIGN KEY (object_id) REFERENCES objects(id),
                              CONSTRAINT fk_object_media_media FOREIGN KEY (media_id) REFERENCES media(id)
) ENGINE=InnoDB;

CREATE TABLE service_media (
                               service_id BIGINT NOT NULL,
                               media_id BIGINT NOT NULL,
                               is_primary BOOLEAN NOT NULL DEFAULT FALSE,
                               linked_at DATETIME NOT NULL,
                               PRIMARY KEY (service_id, media_id),
                               INDEX idx_service_media_media (media_id),
                               CONSTRAINT fk_service_media_service FOREIGN KEY (service_id) REFERENCES services(id),
                               CONSTRAINT fk_service_media_media FOREIGN KEY (media_id) REFERENCES media(id)
) ENGINE=InnoDB;

CREATE TABLE user_requests_object (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      requester_user_id BIGINT NOT NULL,
                                      object_id BIGINT NOT NULL,
                                      offered_object_id BIGINT NULL,
                                      offered_service_id BIGINT NULL,
                                      request_message TEXT,
                                      status VARCHAR(30) NOT NULL DEFAULT 'pending',
                                      created_at DATETIME NOT NULL,
                                      updated_at DATETIME NOT NULL,
                                      INDEX idx_uro_requester (requester_user_id),
                                      INDEX idx_uro_object (object_id),
                                      INDEX idx_uro_offered_object (offered_object_id),
                                      INDEX idx_uro_offered_service (offered_service_id),
                                      INDEX idx_uro_status (status),
                                      CONSTRAINT fk_uro_requester FOREIGN KEY (requester_user_id) REFERENCES users(id),
                                      CONSTRAINT fk_uro_object FOREIGN KEY (object_id) REFERENCES objects(id),
                                      CONSTRAINT fk_uro_offered_object FOREIGN KEY (offered_object_id) REFERENCES objects(id),
                                      CONSTRAINT fk_uro_offered_service FOREIGN KEY (offered_service_id) REFERENCES services(id)
) ENGINE=InnoDB;

CREATE TABLE user_requests_service (
                                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       requester_user_id BIGINT NOT NULL,
                                       service_id BIGINT NOT NULL,
                                       offered_object_id BIGINT NULL,
                                       offered_service_id BIGINT NULL,
                                       request_message TEXT,
                                       status VARCHAR(30) NOT NULL DEFAULT 'pending',
                                       created_at DATETIME NOT NULL,
                                       updated_at DATETIME NOT NULL,
                                       INDEX idx_urs_requester (requester_user_id),
                                       INDEX idx_urs_service (service_id),
                                       INDEX idx_urs_offered_object (offered_object_id),
                                       INDEX idx_urs_offered_service (offered_service_id),
                                       INDEX idx_urs_status (status),
                                       CONSTRAINT fk_urs_requester FOREIGN KEY (requester_user_id) REFERENCES users(id),
                                       CONSTRAINT fk_urs_service FOREIGN KEY (service_id) REFERENCES services(id),
                                       CONSTRAINT fk_urs_offered_object FOREIGN KEY (offered_object_id) REFERENCES objects(id),
                                       CONSTRAINT fk_urs_offered_service FOREIGN KEY (offered_service_id) REFERENCES services(id)
) ENGINE=InnoDB;

CREATE TABLE trades (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        initiated_by_user_id BIGINT NOT NULL,
                        receiver_user_id BIGINT NOT NULL,
                        object_request_id BIGINT NULL,
                        service_request_id BIGINT NULL,
                        trade_type VARCHAR(30) NOT NULL,
                        status VARCHAR(30) NOT NULL DEFAULT 'in_progress',
                        meeting_address_id BIGINT NULL,
                        agreed_at DATETIME NULL,
                        completed_at DATETIME NULL,
                        cancelled_at DATETIME NULL,
                        created_at DATETIME NOT NULL,
                        updated_at DATETIME NOT NULL,
                        INDEX idx_trades_initiated_by (initiated_by_user_id),
                        INDEX idx_trades_receiver (receiver_user_id),
                        INDEX idx_trades_object_request (object_request_id),
                        INDEX idx_trades_service_request (service_request_id),
                        INDEX idx_trades_status (status),
                        CONSTRAINT fk_trades_initiated_by FOREIGN KEY (initiated_by_user_id) REFERENCES users(id),
                        CONSTRAINT fk_trades_receiver FOREIGN KEY (receiver_user_id) REFERENCES users(id),
                        CONSTRAINT fk_trades_object_request FOREIGN KEY (object_request_id) REFERENCES user_requests_object(id),
                        CONSTRAINT fk_trades_service_request FOREIGN KEY (service_request_id) REFERENCES user_requests_service(id),
                        CONSTRAINT fk_trades_meeting_address FOREIGN KEY (meeting_address_id) REFERENCES addresses(id)
) ENGINE=InnoDB;

CREATE TABLE conversations (
                               id BIGINT AUTO_INCREMENT PRIMARY KEY,
                               created_by_user_id BIGINT NOT NULL,
                               related_object_request_id BIGINT NULL,
                               related_service_request_id BIGINT NULL,
                               created_at DATETIME NOT NULL,
                               updated_at DATETIME NOT NULL,
                               is_active BOOLEAN NOT NULL DEFAULT TRUE,
                               INDEX idx_conversations_user (created_by_user_id),
                               INDEX idx_conversations_object_request (related_object_request_id),
                               INDEX idx_conversations_service_request (related_service_request_id),
                               INDEX idx_conversations_active (is_active),
                               CONSTRAINT fk_conversations_user FOREIGN KEY (created_by_user_id) REFERENCES users(id),
                               CONSTRAINT fk_conversations_object_request FOREIGN KEY (related_object_request_id) REFERENCES user_requests_object(id),
                               CONSTRAINT fk_conversations_service_request FOREIGN KEY (related_service_request_id) REFERENCES user_requests_service(id)
) ENGINE=InnoDB;

CREATE TABLE conversation_participants (
                                           conversation_id BIGINT NOT NULL,
                                           user_id BIGINT NOT NULL,
                                           joined_at DATETIME NOT NULL,
                                           last_read_at DATETIME NULL,
                                           PRIMARY KEY (conversation_id, user_id),
                                           INDEX idx_cp_user (user_id),
                                           CONSTRAINT fk_cp_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
                                           CONSTRAINT fk_cp_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE messages (
                          id BIGINT AUTO_INCREMENT PRIMARY KEY,
                          conversation_id BIGINT NOT NULL,
                          sender_user_id BIGINT NOT NULL,
                          message_text TEXT NOT NULL,
                          sent_at DATETIME NOT NULL,
                          read_at DATETIME NULL,
                          is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
                          INDEX idx_messages_conversation (conversation_id),
                          INDEX idx_messages_sender (sender_user_id),
                          INDEX idx_messages_sent_at (sent_at),
                          CONSTRAINT fk_messages_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
                          CONSTRAINT fk_messages_sender FOREIGN KEY (sender_user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE reports (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         reporter_user_id BIGINT NOT NULL,
                         reported_user_id BIGINT NULL,
                         reported_object_id BIGINT NULL,
                         reported_service_id BIGINT NULL,
                         related_trade_id BIGINT NULL,
                         reason VARCHAR(100) NOT NULL,
                         details TEXT,
                         status VARCHAR(30) NOT NULL DEFAULT 'open',
                         created_at DATETIME NOT NULL,
                         updated_at DATETIME NOT NULL,
                         INDEX idx_reports_reporter (reporter_user_id),
                         INDEX idx_reports_reported_user (reported_user_id),
                         INDEX idx_reports_object (reported_object_id),
                         INDEX idx_reports_service (reported_service_id),
                         INDEX idx_reports_trade (related_trade_id),
                         INDEX idx_reports_status (status),
                         CONSTRAINT fk_reports_reporter FOREIGN KEY (reporter_user_id) REFERENCES users(id),
                         CONSTRAINT fk_reports_reported_user FOREIGN KEY (reported_user_id) REFERENCES users(id),
                         CONSTRAINT fk_reports_object FOREIGN KEY (reported_object_id) REFERENCES objects(id),
                         CONSTRAINT fk_reports_service FOREIGN KEY (reported_service_id) REFERENCES services(id),
                         CONSTRAINT fk_reports_trade FOREIGN KEY (related_trade_id) REFERENCES trades(id)
) ENGINE=InnoDB;

CREATE TABLE moderation_actions (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    report_id BIGINT NOT NULL,
                                    moderator_user_id BIGINT NOT NULL,
                                    action_type VARCHAR(50) NOT NULL,
                                    action_notes TEXT,
                                    created_at DATETIME NOT NULL,
                                    INDEX idx_ma_report (report_id),
                                    INDEX idx_ma_moderator (moderator_user_id),
                                    INDEX idx_ma_action_type (action_type),
                                    CONSTRAINT fk_ma_report FOREIGN KEY (report_id) REFERENCES reports(id),
                                    CONSTRAINT fk_ma_moderator FOREIGN KEY (moderator_user_id) REFERENCES users(id)
) ENGINE=InnoDB;

#Schema verification

SHOW TABLES;

#Table structure verification

DESCRIBE places;
DESCRIBE users;
DESCRIBE objects;
DESCRIBE services;
DESCRIBE messages;
