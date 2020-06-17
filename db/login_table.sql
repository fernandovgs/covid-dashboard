DROP EXTENSION IF EXISTS pgcrypto;
DROP TABLE IF EXISTS Log_Acesso CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP SEQUENCE IF EXISTS Log_Acesso_seq;
DROP SEQUENCE IF EXISTS Usuario_seq;

DROP FUNCTION login_banco(tentar_login varchar, tentar_senha varchar);

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
CREATE SEQUENCE usuario_seq START 1;
CREATE SEQUENCE log_acesso_seq START 1;

-- New data
INSERT INTO Usuario (id_usuario, papel, login, senha)
VALUES (nextval('usuario_seq'), 'ADMIN', 'adminCovid', crypt('superAdmin', gen_salt('md5')));

INSERT INTO Log_Acesso (id_log, id_usuario, data_acesso)
VALUES (nextval('log_acesso_seq'), 1, CURRENT_TIMESTAMP);

-- Access database through login
CREATE OR REPLACE FUNCTION login_banco(tentar_login varchar, tentar_senha varchar) RETURNS BOOLEAN AS '
	DECLARE
		has_login INTEGER;
		has_logged BOOLEAN;
	BEGIN
		SELECT 	U.id_usuario INTO has_login
		FROM 	Usuario U
		WHERE 	U.login = tentar_login;

		IF has_login IS NOT NULL THEN
			SELECT U.senha = crypt(''superAdmin'', U.senha) INTO has_logged FROM Usuario U WHERE U.id_usuario = has_login;

			IF has_logged = TRUE THEN

				INSERT INTO Log_Acesso(id_log, id_usuario, data_acesso)
				VALUES (nextval(''log_acesso_seq''), has_login, CURRENT_TIMESTAMP);
				RETURN TRUE;

			ELSE
				RETURN FALSE;
			END IF;
		ELSE
			RETURN FALSE;
		END IF;
	END;
'
LANGUAGE plpgsql;