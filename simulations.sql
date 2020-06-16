-- DROP FUNCTION simulacao_medicina();
-- DROP FUNCTION destruir_simulacao_medicina();

CREATE OR REPLACE FUNCTION simulacao_medicina() RETURNS VOID AS '
    BEGIN
        CREATE TABLE prontuario_sim AS TABLE prontuario;
        CREATE TABLE atendimento_sim AS TABLE atendimento;

        ALTER TABLE atendimento_sim ADD CONSTRAINT atendimento_sim_pk PRIMARY KEY (id_atendimento);
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_medico_atendimento_sim_fk FOREIGN KEY (id_medico)
            REFERENCES public.medico (id_medico) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_paciente_atendimento_sim_fk FOREIGN KEY (id_paciente)
            REFERENCES public.paciente (id_paciente) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
        ALTER TABLE atendimento_sim ADD CONSTRAINT id_prontuario_atendimento_sim_fk FOREIGN KEY (id_prontuario)
            REFERENCES public.prontuario (id_prontuario) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE; 

        ALTER TABLE prontuario_sim ADD CONSTRAINT id_prontuario_sim_pk PRIMARY KEY (id_prontuario);
        ALTER TABLE prontuario_sim ADD CONSTRAINT id_paciente_prontuario_sim_fk FOREIGN KEY (id_paciente)
            REFERENCES public.paciente (id_paciente) MATCH SIMPLE
            ON UPDATE NO ACTION ON DELETE CASCADE;
    END;
'
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION destruir_simulacao_medicina() RETURNS VOID AS '
    BEGIN
        DROP TABLE prontuario_sim;
        DROP TABLE atendimento_sim;
    END;
' LANGUAGE plpgsql;


