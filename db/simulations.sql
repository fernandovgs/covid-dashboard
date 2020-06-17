DROP FUNCTION simulacao_medicina();
DROP FUNCTION destruir_simulacao_medicina();
DROP FUNCTION simulacao_pesquisa();
DROP FUNCTION destruir_simulacao_pesquisa();
DROP FUNCTION simulacao_medicina_criar_prontuario(id_pac int);
DROP FUNCTION simulacao_medicina_criar_atendimento(
    nova_data date,
    novo_grau_avaliacao char,
    novas_observacoes varchar,
    id_med int,
    id_pac int,
    id_pro int
);
DROP FUNCTION simulacao_medicina_editar_atendimento(
    id_ate int,
    nova_data date,
    novo_grau_avaliacao char,
    novas_observacoes varchar
);
DROP FUNCTION simulacao_pesquisa_criar_amostra(
    nova_data date,
    result char,
    id_lab int,
    id_pac int,
    id_psq int
);
DROP FUNCTION simulacao_pesquisa_editar_amostra(
    id_amo int,
    nova_data date,
    result char
);

CREATE OR REPLACE FUNCTION simulacao_medicina() RETURNS VOID AS '
    DECLARE
        max_id_prontuario INTEGER := (SELECT MAX(id_prontuario) FROM prontuario) + 1;
        max_id_atendimento INTEGER := (SELECT MAX(id_atendimento) FROM atendimento) + 1;
    BEGIN
        CREATE TABLE prontuario_sim AS TABLE prontuario;
        CREATE TABLE atendimento_sim AS TABLE atendimento;

        ALTER TABLE prontuario_sim ADD CONSTRAINT id_prontuario_sim_pk PRIMARY KEY (id_prontuario);
        ALTER TABLE prontuario_sim ADD CONSTRAINT id_paciente_prontuario_sim_fk FOREIGN KEY (id_paciente)
            REFERENCES public.paciente (id_paciente) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;

        ALTER TABLE atendimento_sim ADD CONSTRAINT atendimento_sim_pk PRIMARY KEY (id_atendimento);
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_medico_atendimento_sim_fk FOREIGN KEY (id_medico)
            REFERENCES public.medico (id_medico) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_paciente_atendimento_sim_fk FOREIGN KEY (id_paciente)
            REFERENCES public.paciente (id_paciente) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_prontuario_atendimento_sim_fk FOREIGN KEY (id_prontuario)
            REFERENCES public.prontuario_sim (id_prontuario) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE; 

        EXECUTE ''CREATE SEQUENCE prontuario_sim_seq START '' || max_id_prontuario;
        EXECUTE ''CREATE SEQUENCE atendimento_sim_seq START '' || max_id_atendimento;
    END;
'
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION destruir_simulacao_medicina() RETURNS VOID AS '
    BEGIN
        DROP TABLE atendimento_sim;
        DROP TABLE prontuario_sim;

        DROP SEQUENCE prontuario_sim_seq;
        DROP SEQUENCE atendimento_sim_seq;
    END;
' LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_pesquisa() RETURNS VOID AS '
    DECLARE
        max_id_amostra INTEGER := (SELECT MAX(id_amostra) FROM amostra) + 1;
    BEGIN
        CREATE TABLE amostra_sim AS TABLE amostra;

        ALTER TABLE amostra_sim ADD CONSTRAINT amostra_sim_pk PRIMARY KEY (id_amostra);
        ALTER TABLE amostra_sim ADD CONSTRAINT id_laboratorio_amostra_sim_fk FOREIGN KEY (id_laboratorio)
            REFERENCES public.laboratorio (id_laboratorio) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE amostra_sim ADD CONSTRAINT id_paciente_amostra_sim_fk FOREIGN KEY (id_paciente)
            REFERENCES public.paciente (id_paciente) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE amostra_sim ADD CONSTRAINT id_pesquisador_amostra_sim_fk FOREIGN KEY (id_pesquisador)
            REFERENCES public.pesquisador (id_pesquisador) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;

        EXECUTE ''CREATE SEQUENCE amostra_sim_seq START '' || max_id_amostra;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION destruir_simulacao_pesquisa() RETURNS VOID AS '
    BEGIN
        DROP TABLE amostra_sim;

        DROP SEQUENCE amostra_sim_seq;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_medicina_criar_prontuario(id_pac int) RETURNS VOID AS '
    BEGIN
        INSERT INTO prontuario_sim(id_prontuario, id_paciente)
        VALUES (nextval(''prontuario_sim_seq''), id_pac);
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_medicina_criar_atendimento(
    nova_data date,
    novo_grau_avaliacao char,
    novas_observacoes varchar,
    id_med int,
    id_pac int,
    id_pro int
)
RETURNS VOID AS '
    BEGIN
        INSERT INTO atendimento_sim(id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
        VALUES (nextval(''atendimento_sim_seq''), nova_data, novo_grau_avaliacao, novas_observacoes, id_med, id_pac, id_pro);
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_medicina_editar_atendimento(
    id_ate int,
    nova_data date,
    novo_grau_avaliacao char,
    novas_observacoes varchar
)
RETURNS VOID AS '
    BEGIN
        UPDATE atendimento_sim
        SET data = nova_data,
            grau_avaliacao = novo_grau_avaliacao,
            observacoes = novas_observacoes
        WHERE id_atendimento = id_ate;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_pesquisa_criar_amostra(
    nova_data date,
    result char,
    id_lab int,
    id_pac int,
    id_psq int
)
RETURNS VOID AS '
    BEGIN
        INSERT INTO amostra_sim(id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
        VALUES (nextval(''amostra_sim_seq''), nova_data, result, id_lab, id_pac, id_psq);
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION simulacao_pesquisa_editar_amostra(
    id_amo int,
    nova_data date,
    result char
)
RETURNS VOID AS '
    BEGIN
        UPDATE amostra_sim
        SET data = nova_data,
            resultado = result
        WHERE id_amostra = id_amo;
    END;
'
LANGUAGE plpgsql;
