CREATE OR REPLACE TYPE report_one AS 
	("name" varchar, age int, gender char, birth date, phones varchar, address varchar, hospital varchar);

CREATE OR REPLACE FUNCTION personal_history()
RETURNS SETOF report_one AS '
BEGIN
	RETURN QUERY SELECT
		PES.nome AS "Nome",
		PES.idade AS "Idade",
		PES.sexo AS "Sexo",
		PES.data_nasc AS "Data de Nascimento",
		PES.telefone_fixo||'' , '' ||PES.telefone_celular AS "Contato telefônico",
		PES.cidade||'' - ''||PES.estado||'' - ''||PES.pais AS "Endereço Completo",
		HOS.nome AS "Hospital"
	FROM	pessoa PES, paciente PAC, hospital HOS
	WHERE
		PAC.id_paciente = PES.id_pessoa AND
		PAC.id_hospital = HOS.id_hospital;
END;
'
LANGUAGE plpgsql;