-- DROP FUNCTION total_positivos();
-- DROP FUNCTION total_suspeitos();
-- DROP FUNCTION hospitais_com_mais_pacientes_mes();
-- DROP FUNCTION laboratorios_com_mais_analises_mes();
-- DROP FUNCTION laboratorios_casos_positivos();
-- DROP FUNCTION laboratorios_casos_suspeitos();

-- DROP TYPE top_20_medicos;
-- DROP TYPE top_20_laboratorios;
-- DROP TYPE top_20_cidades;

CREATE TYPE top_20_medicos AS (nome_hospital varchar, qtde_atendimentos bigint);
CREATE TYPE top_20_laboratorios AS (nome_laboratorio varchar, qtde_analises bigint);
CREATE TYPE top_20_cidades AS (nome_cidade character(60), qtde_casos bigint);

CREATE OR REPLACE FUNCTION total_suspeitos() RETURNS INTEGER AS 
'
    DECLARE
        total_p INTEGER;
    BEGIN
        total_p := (
            SELECT
                count(DISTINCT PAC.id_paciente) AS "Número casos suspeitos"
            FROM
                paciente PAC,
                amostra AMO
            WHERE
                AMO.id_paciente = PAC.id_paciente
            );

        RETURN total_p;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION total_positivos() RETURNS INTEGER AS 
'
    DECLARE
        total_p INTEGER;
    BEGIN
        total_p := (
            SELECT
                count(DISTINCT PAC.id_paciente) AS "Número casos suspeitos"
            FROM
                paciente PAC,
                amostra AMO
            WHERE
                AMO.id_paciente = PAC.id_paciente AND
                AMO.resultado LIKE ''P''
            );

        RETURN total_p;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hospitais_com_mais_pacientes_mes()
RETURNS SETOF top_20_medicos AS 
'
    BEGIN
        RETURN QUERY SELECT
            HOS.nome,
            count(DISTINCT ATE.id_paciente)
        FROM
            hospital HOS,
            paciente PAC,
            atendimento ATE
        WHERE
            HOS.id_hospital = PAC.id_hospital AND
            ATE.id_paciente = PAC.id_paciente AND
            EXTRACT(MONTH FROM now()) = EXTRACT(MONTH FROM ATE."data")
        GROUP BY HOS.nome
        LIMIT 20;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION laboratorios_com_mais_analises_mes()
RETURNS SETOF top_20_laboratorios AS 
'
    BEGIN
        RETURN QUERY SELECT
            LAB.nome,
            count(AMO.id_laboratorio)
        FROM
            laboratorio LAB,
            amostra AMO
        WHERE
            AMO.id_laboratorio = LAB.id_laboratorio AND
            EXTRACT(MONTH FROM now()) = EXTRACT(MONTH FROM AMO."data")
        GROUP BY LAB.nome
        ORDER BY count(AMO.id_laboratorio) DESC
        LIMIT 20;
    END;
'
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION laboratorios_casos_positivos()
RETURNS SETOF top_20_cidades AS 
'
    BEGIN
        RETURN QUERY SELECT
            PES.cidade AS "Cidade",
            count(DISTINCT PAC.id_paciente) AS "Casos positivos"
        FROM
            pessoa PES,
            paciente PAC,
            amostra AMO
        WHERE
            PES.id_pessoa = PAC.id_paciente AND
            AMO.id_paciente = PAC.id_paciente AND
            EXTRACT(MONTH FROM AMO."data") = EXTRACT(MONTH FROM now()) AND
            AMO.resultado LIKE ''P''
        GROUP BY PES.cidade
        ORDER BY count(DISTINCT PAC.id_paciente) DESC
        LIMIT 20;
    END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION laboratorios_casos_suspeitos()
RETURNS SETOF top_20_cidades AS 
'
    BEGIN
        RETURN QUERY SELECT
            PES.cidade AS "Cidade",
            count(DISTINCT PAC.id_paciente) AS "Casos suspeitos"
        FROM
            pessoa PES,
            paciente PAC,
            amostra AMO
        WHERE
            PES.id_pessoa = PAC.id_paciente AND
            AMO.id_paciente = PAC.id_paciente AND
            EXTRACT(MONTH FROM AMO."data") = EXTRACT(MONTH FROM now())
        GROUP BY PES.cidade
        ORDER BY count(DISTINCT PAC.id_paciente) DESC
        LIMIT 20;
    END;
'
LANGUAGE plpgsql;


