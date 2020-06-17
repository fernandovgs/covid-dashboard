/* ######################################################### */
/* Comandos para excluir todas as tabelas -- ORACLE			 */
/* ######################################################### */
-- DROP TABLE Hospital CASCADE CONSTRAINTS;
-- DROP TABLE Pessoa CASCADE CONSTRAINTS;
-- DROP TABLE Paciente CASCADE CONSTRAINTS;
-- DROP TABLE Credencial CASCADE CONSTRAINTS;
-- DROP TABLE Funcionario CASCADE CONSTRAINTS;
-- DROP TABLE Prontuario CASCADE CONSTRAINTS;
-- DROP TABLE Medico CASCADE CONSTRAINTS;
-- DROP TABLE Pesquisador CASCADE CONSTRAINTS;
-- DROP TABLE Laboratorio CASCADE CONSTRAINTS;
-- DROP TABLE Amostra CASCADE CONSTRAINTS;
-- DROP TABLE Atendimento CASCADE CONSTRAINTS;
-- DROP TABLE FuncConsultaProntuario CASCADE CONSTRAINTS;
-- DROP TABLE HospitalCredenciaLaboratorio CASCADE CONSTRAINTS;
-- DROP TABLE MedicoCriaProntuario CASCADE CONSTRAINTS;
-- DROP TABLE MedicoEditaProntuario CASCADE CONSTRAINTS;

/* ######################################################### */
/* Comandos para excluir todas as tabelas -- POSTGRESql		 */
/* ######################################################### */
-- DROP TABLE IF EXISTS Hospital CASCADE;
-- DROP TABLE IF EXISTS Pessoa CASCADE;
-- DROP TABLE IF EXISTS Paciente CASCADE;
-- DROP TABLE IF EXISTS Credencial CASCADE;
-- DROP TABLE IF EXISTS Funcionario CASCADE;
-- DROP TABLE IF EXISTS Prontuario CASCADE;
-- DROP TABLE IF EXISTS Medico CASCADE;
-- DROP TABLE IF EXISTS Pesquisador CASCADE;
-- DROP TABLE IF EXISTS Laboratorio CASCADE;
-- DROP TABLE IF EXISTS Amostra CASCADE;
-- DROP TABLE IF EXISTS Atendimento CASCADE;
-- DROP TABLE IF EXISTS FuncConsultaProntuario CASCADE;
-- DROP TABLE IF EXISTS HospitalCredenciaLaboratorio CASCADE;
-- DROP TABLE IF EXISTS MedicoCriaProntuario CASCADE;
-- DROP TABLE IF EXISTS MedicoEditaProntuario CASCADE;


/* ######################################################### */
/* Script para criar todas as tabelas do BD COVID-19 		 */
/* ######################################################### */
-- DROP TABLE Hospital CASCADE CONSTRAINTS;
CREATE TABLE Hospital (
	id_hospital INT NOT NULL,
	nome VARCHAR(150) NOT NULL,
	qtd_funcionario INTEGER,
	qtd_leitos INTEGER,
	cidade CHAR(60),
	estado CHAR(60),
	pais VARCHAR(60),

	CONSTRAINT id_hospital_pk PRIMARY KEY(id_hospital)
);

CREATE TABLE Pessoa (
	id_pessoa INT NOT NULL,
	nome VARCHAR(150) DEFAULT NULL,
	idade INT DEFAULT NULL,
	sexo CHAR(1) DEFAULT NULL,
	data_nasc DATE DEFAULT NULL,
	telefone_fixo CHAR(10),
	telefone_celular CHAR(11),
	cidade CHAR(60),
	estado CHAR(60),
	pais VARCHAR(60),
	id_hospital INT NOT NULL,

	CONSTRAINT pessoa_pk PRIMARY KEY (id_pessoa),
	CONSTRAINT id_Hospital_fk FOREIGN KEY (id_Hospital) REFERENCES Hospital(id_Hospital) ON DELETE CASCADE

);

CREATE TABLE Paciente (
	id_paciente INT NOT NULL,
	id_hospital INT NOT NULL,

	CONSTRAINT id_paciente_pk PRIMARY KEY (id_paciente),
	CONSTRAINT id_paciente_fk FOREIGN KEY (id_paciente) REFERENCES Pessoa(id_pessoa) ON DELETE CASCADE,
	CONSTRAINT id_hospital_paciente_fk FOREIGN KEY (id_hospital) REFERENCES Hospital(id_hospital) ON DELETE CASCADE
 );

CREATE TABLE Credencial (
	login VARCHAR(16) NOT NULL,
	senha VARCHAR(16) NOT NULL,

	CONSTRAINT login_pk PRIMARY KEY (login)
);

CREATE TABLE Funcionario (
	id_funcionario INT NOT NULL,
	registro_institucional INT NOT NULL,
	data_contratacao DATE,
	departamento VARCHAR(20),
	login VARCHAR(16) NOT NULL,

	CONSTRAINT id_funcionario_pk PRIMARY KEY (id_funcionario),
	CONSTRAINT id_funcionario_fk FOREIGN KEY (id_funcionario) REFERENCES Pessoa (id_pessoa) ON DELETE CASCADE,
	CONSTRAINT login_fk FOREIGN KEY (login) REFERENCES Credencial (login) ON DELETE CASCADE
);

CREATE TABLE Prontuario (
	id_prontuario INT NOT NULL,
	id_paciente INT NOT NULL,

	CONSTRAINT id_prontuario_pk PRIMARY KEY (id_prontuario),
	CONSTRAINT id_paciente_prontuario_fk FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE
);

CREATE TABLE Medico (
	id_medico INT NOT NULL,
	crm INT NOT NULL,

	CONSTRAINT id_medico_pk PRIMARY KEY (id_medico),
	CONSTRAINT id_medico_fk FOREIGN KEY (id_medico) REFERENCES Funcionario(id_funcionario) ON DELETE CASCADE
);

CREATE TABLE Pesquisador (
	id_pesquisador INT NOT NULL,
	crm INT NOT NULL,

	CONSTRAINT id_pesquisador_pk PRIMARY KEY (id_pesquisador),
	CONSTRAINT id_pesquisador_fk FOREIGN KEY (id_pesquisador) REFERENCES Funcionario(id_funcionario) ON DELETE CASCADE
 );

CREATE TABLE Laboratorio (
	id_laboratorio INT NOT NULL,
	nome VARCHAR(150) NOT NULL,
	qtd_pesquisadores INTEGER,
	cidade CHAR(60),
	estado CHAR(60),
	pais VARCHAR(20),

	CONSTRAINT id_laboratorio_pk PRIMARY KEY (id_laboratorio)
);

CREATE TABLE Amostra (
	id_amostra  INT NOT NULL,
	data DATE,
	resultado CHAR(1) NOT NULL, /*N OU P*/
	id_laboratorio  INT NOT NULL,
	id_paciente  INT NOT NULL,
	id_pesquisador INT NOT NULL,

	CONSTRAINT amostra_pk PRIMARY KEY (id_amostra),
	CONSTRAINT id_laboratorio_amostra_fk FOREIGN KEY(id_laboratorio) REFERENCES Laboratorio(id_laboratorio) ON DELETE CASCADE,
	CONSTRAINT id_paciente_amostra_fk FOREIGN KEY(id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE,
	CONSTRAINT id_pesquisador_amostra_fk FOREIGN KEY(id_pesquisador) REFERENCES Pesquisador(id_pesquisador) ON DELETE CASCADE
);

CREATE TABLE Atendimento (
	id_atendimento INT NOT NULL,
	data DATE,
	grau_avaliacao CHAR(1), /*B-baixo,M-medio,A-Alto, I-Infectado*/
	observacoes VARCHAR(256),
	id_medico INT NOT NULL,
	id_paciente INT NOT NULL,
	id_prontuario INT NOT NULL,

	CONSTRAINT atendimento_pk PRIMARY KEY (id_atendimento),
	CONSTRAINT id_medico_atendimento_fk FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON DELETE CASCADE,  
	CONSTRAINT id_paciente_atendimento_fk FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE,
	CONSTRAINT id_prontuario_atendimento_fk FOREIGN KEY (id_prontuario) REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE
);

CREATE TABLE FuncConsultaProntuario(
	id_FCP INT NOT NULL,
	id_funcionario INT NOT NULL,
	id_prontuario INT NOT NULL,

	CONSTRAINT id_funcionario_FCP_pk PRIMARY KEY (id_FCP),
	CONSTRAINT id_funcionario_FCP_fk FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario) ON DELETE CASCADE,
	CONSTRAINT id_prontuario_FCP_fk FOREIGN KEY (id_prontuario) REFERENCES Prontuario (id_prontuario) ON DELETE CASCADE

);

CREATE TABLE HospitalCredenciaLaboratorio (
	id_HCL INT NOT NULL,
	id_hospital INT NOT NULL,
	id_laboratorio INT NOT NULL,

	CONSTRAINT id_HCL_pk PRIMARY KEY (id_HCL),
	CONSTRAINT id_hospital_HCL_fk FOREIGN KEY (id_hospital) REFERENCES Hospital (id_hospital) ON DELETE CASCADE,
	CONSTRAINT id_laboratorio_HCL_fk FOREIGN KEY (id_laboratorio) REFERENCES Laboratorio (id_laboratorio) ON DELETE CASCADE

);

CREATE TABLE MedicoCriaProntuario (
	id_MCP INT NOT NULL,
	id_medico INT NOT NULL,
	id_prontuario INT NOT NULL,

	CONSTRAINT id_MCP_pk PRIMARY KEY (id_MCP),
	CONSTRAINT id_medico_MCP_fk FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON DELETE CASCADE,  
	CONSTRAINT id_prontuario_MCP_fk FOREIGN KEY (id_prontuario) REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE

);

CREATE TABLE MedicoEditaProntuario (
	id_MEP INT NOT NULL,
	id_medico INT NOT NULL,
	id_prontuario INT NOT NULL,

	CONSTRAINT id_medico_MEP_pk PRIMARY KEY (id_MEP),
	CONSTRAINT id_medico_MEP_fk FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON DELETE CASCADE,  
	CONSTRAINT id_prontuario_MEP_fk FOREIGN KEY (id_prontuario) REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE
);