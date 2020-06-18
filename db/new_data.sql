BEGIN;
	INSERT INTO hospital(id_hospital, nome, qtd_funcionario, qtd_leitos, cidade, estado, pais)
		VALUES (2766, 'Hospital 1', 100, 100, 'São Paulo', 'SP', 'Brasil');
	INSERT INTO hospital(id_hospital, nome, qtd_funcionario, qtd_leitos, cidade, estado, pais)
		VALUES (2767, 'Hospital 2', 100, 100, 'São Paulo', 'SP', 'Brasil');
	INSERT INTO hospital(id_hospital, nome, qtd_funcionario, qtd_leitos, cidade, estado, pais)
		VALUES (2768, 'Hospital 3', 100, 100, 'São Paulo', 'SP', 'Brasil');
	INSERT INTO hospital(id_hospital, nome, qtd_funcionario, qtd_leitos, cidade, estado, pais)
		VALUES (2769, 'Hospital 4', 100, 100, 'São Paulo', 'SP', 'Brasil');
	INSERT INTO hospital(id_hospital, nome, qtd_funcionario, qtd_leitos, cidade, estado, pais)
		VALUES (2770, 'Hospital 5', 100, 100, 'São Paulo', 'SP', 'Brasil');

	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18842, 'Pessoa Nova 1', 30, 'f', '2000-01-01', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2766);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18843, 'Pessoa Nova 2', 30, 'f', '2000-01-02', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2766);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18844, 'Pessoa Nova 3', 30, 'f', '2000-01-03', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2767);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18845, 'Pessoa Nova 4', 30, 'f', '2000-01-04', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2767);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18846, 'Pessoa Nova 5', 30, 'f', '2000-01-05', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2767);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18847, 'Pessoa Nova 6', 30, 'f', '2000-01-06', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2767);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18848, 'Pessoa Nova 7', 30, 'f', '2000-01-07', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2768);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18849, 'Pessoa Nova 8', 30, 'f', '2000-01-08', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2769);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18850, 'Pessoa Nova 9', 30, 'f', '2000-01-09', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2770);
	INSERT INTO pessoa(id_pessoa, nome, idade, sexo, data_nasc, telefone_fixo, telefone_celular, cidade, estado, pais, id_hospital)
		VALUES (18851, 'Pessoa Nova 10', 30, 'f', '2000-01-10', NULL, NULL, 'São Paulo', 'SP', 'Brasil', 2770);

	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18842, 2766);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18843, 2766);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18844, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18845, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18846, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18847, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18848, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18849, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18850, 2767);
	INSERT INTO paciente (id_paciente, id_hospital)
		VALUES (18851, 2767);

	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118842, 18842);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118843, 18843);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118844, 18844);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118845, 18845);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118846, 18846);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118847, 18847);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118848, 18848);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118849, 18849);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118850, 18850);
	INSERT INTO prontuario (id_prontuario, id_paciente)
		VALUES(118851, 18851);

	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000000, now(), 'I', '', 2, 18842, 118842);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000001, now(), 'I', '', 2, 18843, 118843);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000002, now(), 'I', '', 2, 18844, 118844);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000003, now(), 'I', '', 2, 18845, 118845);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000004, now(), 'I', '', 2, 18846, 118846);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000005, now(), 'I', '', 2, 18847, 118847);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000006, now(), 'I', '', 2, 18848, 118848);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000007, now(), 'I', '', 2, 18849, 118849);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000008, now(), 'I', '', 2, 18850, 118850);
	INSERT INTO atendimento (id_atendimento, data, grau_avaliacao, observacoes, id_medico, id_paciente, id_prontuario)
		VALUES (3000009, now(), 'I', '', 2, 18851, 118851);


	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999907, now(), 'N', 270, 18842, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999908, now(), 'N', 270, 18843, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999909, now(), 'N', 270, 18844, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999910, now(), 'N', 270, 18845, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999911, now(), 'N', 270, 18846, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999912, now(), 'P', 270, 18847, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999913, now(), 'P', 270, 18848, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999914, now(), 'P', 270, 18849, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999915, now(), 'P', 270, 18850, 11986);
	INSERT INTO amostra (id_amostra, data, resultado, id_laboratorio, id_paciente, id_pesquisador)
		VALUES (2999916, now(), 'P', 270, 18851, 11986);

	COMMIT;
END;