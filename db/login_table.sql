DROP EXTENSION IF EXISTS pgcrypto;
DROP TABLE IF EXISTS Log_Acesso CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP SEQUENCE IF EXISTS Log_Acesso_seq;
DROP SEQUENCE IF EXISTS Usuario_seq;

-- Add extension for encryption
CREATE EXTENSION pgcrypto;

-- Set timezone
SET timezone = 'America/Sao_Paulo';

-- New tables for 'login' and 'login logs'
CREATE TABLE Usuario (
	id_usuario INT NOT NULL,
	papel VARCHAR(11) NOT NULL,
	login VARCHAR(30) NOT NULL UNIQUE,
	senha VARCHAR(255) NOT NULL,

	CONSTRAINT usuario_pk PRIMARY KEY (id_usuario)
);

CREATE TABLE Log_Acesso (
	id_log INT NOT NULL,
	id_usuario INT NOT NULL,
	data_acesso TIMESTAMP NOT NULL,

	CONSTRAINT log_pk PRIMARY KEY (id_log),
	CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- New sequences
CREATE SEQUENCE Usuario_seq START 1;
CREATE SEQUENCE Log_Acesso_seq START 1;

-- New data
INSERT INTO Usuario (id_usuario, papel, login, senha)
VALUES (1, 'ADMIN', 'adminCovid', crypt('superAdmin', gen_salt('md5')));

INSERT INTO Log_Acesso (id_log, id_usuario, data_acesso)
VALUES (1, 1, CURRENT_TIMESTAMP);
