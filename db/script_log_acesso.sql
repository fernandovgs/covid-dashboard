INSERT INTO Log_Acesso(id_log, id_usuario, data_acesso)
    VALUES (nextval('log_acesso_seq'), %s, CURRENT_TIMESTAMP);
