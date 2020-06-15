DROP FUNCTION historico_pessoal();
DROP FUNCTION historico_hospital();
DROP FUNCTION historico_municipios();

DROP TYPE relatorio_um;
DROP TYPE relatorio_dois;
DROP TYPE relatorio_tres;

CREATE TYPE relatorio_um AS 
    (nome varchar, idade int, genero char, data_nasc date, telefones text, endereco text, hospital varchar);

CREATE TYPE relatorio_dois AS 
    (nome varchar, endereco text, qtde_funcionarios int, qtde_leitos int, qtde_atendimentos int, qtde_pacientes int);

CREATE TYPE relatorio_tres AS 
    (cidade character(60),
    qtde_pacientes bigint,
    qtde_atendimentos bigint,
    qtde_atendimentos_jan bigint,
    qtde_atendimentos_fev bigint,
    qtde_atendimentos_mar bigint,
    qtde_atendimentos_abr bigint,
    qtde_atendimentos_mai bigint,
    qtde_atendimentos_jun bigint,
    qtde_atendimentos_jul bigint,
    qtde_atendimentos_ago bigint,
    qtde_atendimentos_set bigint,
    qtde_atendimentos_out bigint,
    qtde_atendimentos_nov bigint,
    qtde_atendimentos_dez bigint);


CREATE OR REPLACE FUNCTION historico_pessoal()
RETURNS SETOF relatorio_um AS '
BEGIN
    RETURN QUERY SELECT
        PES.nome AS "Nome",
        PES.idade AS "Idade",
        PES.sexo AS "Sexo",
        PES.data_nasc AS "Data de Nascimento",
        PES.telefone_fixo||'' , '' ||PES.telefone_celular AS "Contato telefônico",
        PES.cidade||'' - ''||PES.estado||'' - ''||PES.pais AS "Endereço Completo",
        HOS.nome AS "Hospital"
    FROM    pessoa PES, paciente PAC, hospital HOS
    WHERE
        PAC.id_paciente = PES.id_pessoa AND
        PAC.id_hospital = HOS.id_hospital;
END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION historico_hospital()
RETURNS SETOF relatorio_dois AS '
BEGIN
    RETURN QUERY SELECT
        HOS.nome AS "Nome",
        HOS.cidade||'' - ''||HOS.estado||'' - ''||HOS.pais AS "Endereço Completo",
        HOS.qtd_funcionario AS "Quantidade de funcionários",
        HOS.qtd_leitos AS "Quantidade de leitos",
        count(ATE.id_paciente) AS "Quantidade de atendimentos registrados",
        count(DISTINCT ATE.id_paciente) AS "Quantidade de pacientes distintos atendidos"
    FROM hospital HOS, paciente PAC, atendimento ATE
    WHERE
        HOS.id_hospital = PAC.id_hospital AND
        PAC.id_paciente = ATE.id_paciente
    GROUP BY
        HOS.nome,
        HOS.cidade,
        HOS.estado,
        HOS.pais,
        HOS.qtd_funcionario,
        HOS.qtd_leitos;
END;
'
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION historico_municipios()
RETURNS SETOF relatorio_tres AS '
BEGIN
    RETURN QUERY SELECT 
        TOTAL."Cidade",
        TOTAL."Pacientes distintos",
        TOTAL."Atendimentos realizados",
        TOTAL_JAN."Atendimentos - JAN",
        TOTAL_FEV."Atendimentos - FEV",
        TOTAL_MAR."Atendimentos - MAR",
        TOTAL_ABR."Atendimentos - ABR",
        TOTAL_MAI."Atendimentos - MAI",
        TOTAL_JUN."Atendimentos - JUN",
        TOTAL_JUL."Atendimentos - JUL",
        TOTAL_AGO."Atendimentos - AGO",
        TOTAL_SET."Atendimentos - SET",
        TOTAL_OUT."Atendimentos - OUT",
        TOTAL_NOV."Atendimentos - NOV",
        TOTAL_DEZ."Atendimentos - DEZ"
    FROM
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(DISTINCT ATE.id_paciente) AS "Pacientes distintos",
                count(ATE.id_paciente) AS "Atendimentos realizados"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE.id_paciente = PAC.id_paciente
            GROUP BY HOS.cidade
        ) TOTAL
    LEFT JOIN -- Janeiro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_JAN."data")) AS "Atendimentos - JAN"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_JAN
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_JAN.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_JAN."data") = 1
            GROUP BY HOS.cidade
        ) TOTAL_JAN
    ON TOTAL."Cidade" = TOTAL_JAN."Cidade"
    LEFT JOIN -- Fevereiro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_FEV."data")) AS "Atendimentos - FEV"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_FEV
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_FEV.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_FEV."data") = 2
            GROUP BY HOS.cidade
        ) TOTAL_FEV
    ON TOTAL."Cidade" = TOTAL_FEV."Cidade"
    LEFT JOIN -- Março
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_MAR."data")) AS "Atendimentos - MAR"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_MAR
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_MAR.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_MAR."data") = 3
            GROUP BY HOS.cidade
        ) TOTAL_MAR
    ON TOTAL."Cidade" = TOTAL_MAR."Cidade"
    LEFT JOIN -- Abril
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_ABR."data")) AS "Atendimentos - ABR"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_ABR
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_ABR.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_ABR."data") = 4
            GROUP BY HOS.cidade
        ) TOTAL_ABR
    ON TOTAL."Cidade" = TOTAL_ABR."Cidade"
    LEFT JOIN -- Maio
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_MAI."data")) AS "Atendimentos - MAI"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_MAI
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_MAI.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_MAI."data") = 5
            GROUP BY HOS.cidade
        ) TOTAL_MAI
    ON TOTAL."Cidade" = TOTAL_MAI."Cidade"
    LEFT JOIN -- Junho
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_JUN."data")) AS "Atendimentos - JUN"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_JUN
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_JUN.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_JUN."data") = 6
            GROUP BY HOS.cidade
        ) TOTAL_JUN
    ON TOTAL."Cidade" = TOTAL_JUN."Cidade"
    LEFT JOIN -- Julho
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_JUL."data")) AS "Atendimentos - JUL"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_JUL
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_JUL.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_JUL."data") = 7
            GROUP BY HOS.cidade
        ) TOTAL_JUL
    ON TOTAL."Cidade" = TOTAL_JUL."Cidade"
    LEFT JOIN -- Agosto
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_AGO."data")) AS "Atendimentos - AGO"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_AGO
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_AGO.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_AGO."data") = 8
            GROUP BY HOS.cidade
        ) TOTAL_AGO
    ON TOTAL."Cidade" = TOTAL_AGO."Cidade"
    LEFT JOIN -- Setembro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_SET."data")) AS "Atendimentos - SET"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_SET
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_SET.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_SET."data") = 9
            GROUP BY HOS.cidade
        ) TOTAL_SET
    ON TOTAL."Cidade" = TOTAL_SET."Cidade"
    LEFT JOIN -- Outubro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_OUT."data")) AS "Atendimentos - OUT"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_OUT
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_OUT.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_OUT."data") = 10
            GROUP BY HOS.cidade
        ) TOTAL_OUT
    ON TOTAL."Cidade" = TOTAL_OUT."Cidade"
    LEFT JOIN -- Novembro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_NOV."data")) AS "Atendimentos - NOV"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_NOV
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_NOV.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_NOV."data") = 11
            GROUP BY HOS.cidade
        ) TOTAL_NOV
    ON TOTAL."Cidade" = TOTAL_NOV."Cidade"
    LEFT JOIN -- Dezembro
        (
            SELECT
                HOS.cidade AS "Cidade",
                count(EXTRACT(MONTH FROM ATE_DEZ."data")) AS "Atendimentos - DEZ"
            FROM
                hospital HOS,
                paciente PAC,
                atendimento ATE_DEZ
            WHERE
                HOS.id_hospital = PAC.id_hospital AND
                ATE_DEZ.id_paciente = PAC.id_paciente AND
                EXTRACT(MONTH FROM ATE_DEZ."data") = 12
            GROUP BY HOS.cidade
        ) TOTAL_DEZ
    ON TOTAL."Cidade" = TOTAL_DEZ."Cidade";
END;
'
LANGUAGE plpgsql;
