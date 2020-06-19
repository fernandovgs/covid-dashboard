import psycopg2

ADMIN = 'ADMIN'
MEDICINE = 'MEDICINA'
RESEARCH = 'PESQUISA'

class PGDatabase:
    """
    """

    def __init__(self):
        """
        """
        self.user = ''
        self.role = ''

        try:
            print('Conectado com o banco de dados!\n\n')
        except Exception as e:
            print('Não foi possível se conectar ao banco de dados!')
            print('Fechando programa...')
            raise e

    """ GETTERS E SETTERS
    """
    def setUser(self, user):
        self.user = user

    def getUser(self):
        return self.user

    def getRole(self):
        return self.role
    def setRole(self, role):
        self.role = role

    """ MÉTODOS
    """
    def getConnection(self):
        connection = psycopg2.connect(database='COVID-19',
                                      user = 'postgres',
                                      password = 'postgres',
                                      host = '127.0.0.1',
                                      port = '5432')

        return connection



    def loginDatabase(self, login, password):
        connection = self.getConnection()
        cursor = connection.cursor()

        cursor.callproc('login_banco', (login, password))

        result = cursor.fetchone()

        if result[0] == True:
            print('Usuário {} logado!'.format(login))
            self.setUser(login)

            user = [self.getUser()]
            cursor.callproc('obter_papel', (user))
            role = cursor.fetchone()
            self.setRole(role[0])

            if self.getRole() == ADMIN or self.getRole() == MEDICINE:
                cursor.callproc('simulacao_medicina')
                cursor.fetchall()
            if self.getRole() == ADMIN or self.getRole() == RESEARCH:
                cursor.callproc('simulacao_pesquisa')
                cursor.fetchall()
            
            connection.commit()
            connection.close()
            return True

        print('\tAlgo deu errado. Tente novamente')
        connection.close()
        return False

    def reportOne(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_pessoal')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tIdade: {}'.format(str(row[1])))
            print('\tGênero: {}'.format(row[2]))
            print('\tData de Nascimento: {}'.format(row[3]))
            print('\tTelefones: {}'.format(row[4]))
            print('\tEndereço: {}'.format(row[5]))
            print('\tHospital: {}'.format(row[6]))

        connection.close()

    def reportTwo(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_hospital')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tEndereço: {}'.format(row[1]))
            print('\tQuantidade de funcionários: {}'.format(str(row[2])))
            print('\tQuantidade de leitos: {}'.format(str(row[3])))
            print('\tQuantidade de atendimentos: {}'.format(str(row[4])))
            print('\tQuantidade de pacientes: {}'.format(str(row[5])))
        
        connection.close()

    def reportThree(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_municipios')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tCidade: {}'.format(row[0]))            
            print('\tQuantidade de pacientes: {}'.format(str(row[1])))
            print('\tQuantidade de atendimentos: {}'.format(str(row[2])))
            print('\tQuantidade de atendimentos - jan: {}'.format(str(row[3])))
            print('\tQuantidade de atendimentos - fev: {}'.format(str(row[4])))
            print('\tQuantidade de atendimentos - mar: {}'.format(str(row[5])))
            print('\tQuantidade de atendimentos - abr: {}'.format(str(row[6])))
            print('\tQuantidade de atendimentos - mai: {}'.format(str(row[7])))
            print('\tQuantidade de atendimentos - jun: {}'.format(str(row[8])))
            print('\tQuantidade de atendimentos - jul: {}'.format(str(row[9])))
            print('\tQuantidade de atendimentos - ago: {}'.format(str(row[10])))
            print('\tQuantidade de atendimentos - set: {}'.format(str(row[11])))
            print('\tQuantidade de atendimentos - out: {}'.format(str(row[12])))
            print('\tQuantidade de atendimentos - nov: {}'.format(str(row[13])))
            print('\tQuantidade de atendimentos - dez: {}'.format(str(row[14])))

        connection.close()

    def reportFour(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_amostras')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tIdade: {}'.format(str(row[1])))
            print('\tGênero: {}'.format(row[2]))
            print('\tEndereço: {}'.format(row[3]))
            print('\tData da Amostra: {}'.format(row[4]))
            print('\tResultado: {}'.format(row[5]))
            print('\tLaboratorio: {}'.format(row[6]))

        connection.close()

    def reportFive(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_laboratorios')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tQuantidade de pesquisadores: {}'.format(str(row[1])))
            print('\tEndereço: {}'.format(row[2]))
            print('\tAmostras: {}'.format(row[3]))

        connection.close()

    def reportSix(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        cursor.callproc('historico_pesquisadores')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tRegistro institucional: {}'.format(str(row[1])))
            print('\tData de Contratação: {}'.format(row[2]))
            print('\tIdentificador da Amostra: {}'.format(str(row[3])))
            print('\tData da Amostra: {}'.format(row[4]))
            print('\tResultado: {}'.format(row[5]))

        connection.close()

    def showDashboard(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        ''' casos positivos '''
        cursor.callproc('total_positivos')
        result = cursor.fetchone()
        print('\tTotal de casos positivos: {}'.format(result[0]))

        ''' casos suspeitos '''
        cursor.callproc('total_suspeitos')
        result = cursor.fetchone()
        print('\tTotal de casos suspeitos: {}'.format(result[0]))

        ''' hospitais '''
        cursor.callproc('hospitais_com_mais_pacientes_mes')
        result = cursor.fetchall()
        print('\tHospitais com mais pacientes no mês:')
        for row in result:
            print('\t\t{} - {}'.format(row[0], row[1]))

        ''' laboratórios '''
        cursor.callproc('laboratorios_com_mais_analises_mes')
        result = cursor.fetchall()

        print('\tLaboratórios com mais análises no mês:')
        for row in result:
            print('\t\t{} - {}'.format(row[0], row[1]))



        ''' cidades - casos positivos '''
        cursor.callproc('laboratorios_casos_positivos')
        result = cursor.fetchall()
        
        print('\t20 cidades com mais casos positivos:')
        for row in result:
            print('\t\t{} - {}'.format(row[0], row[1]))



        ''' cidades - casos suspeitos '''
        cursor.callproc('laboratorios_casos_suspeitos')
        result = cursor.fetchall()
        
        print('\t20 cidades com mais casos suspeitos:')
        for row in result:
            print('\t\t{} - {}'.format(row[0], row[1]))

        connection.close()

    def destroySimulations(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        if self.getRole() == ADMIN or self.getRole() == MEDICINE:
            cursor.callproc('destruir_simulacao_medicina')
        if self.getRole() == ADMIN or self.getRole() == RESEARCH:
            cursor.callproc('destruir_simulacao_pesquisa')

        connection.commit()
        connection.close()

    def restoreSimulations(self):
        connection = self.getConnection() 
        cursor = connection.cursor()

        try:
            if self.getRole() == ADMIN or self.getRole() == MEDICINE:
                cursor.callproc('destruir_simulacao_medicina')
                cursor.callproc('simulacao_medicina')
            if self.getRole() == ADMIN or self.getRole() == RESEARCH:
                cursor.callproc('destruir_simulacao_pesquisa')
                cursor.callproc('simulacao_pesquisa')

            connection.commit()
            connection.close()

            print('Valores restaurados!')
        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass


    def simulateCreateMedicalRecord(self):
        id_pac = input('\tInforme o id do paciente a se criar o prontuário: ')

        try:
            connection = self.getConnection() 
            cursor = connection.cursor()

            cursor.callproc('simulacao_medicina_criar_prontuario', (id_pac))

            connection.commit()
            connection.close()
            print('Dados criados com sucesso!')

        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass


    def simulateCreateMedicalCare(self):
        id_pac = input('\tInforme o id do paciente a se criar o atendimento: ')
        id_med = input('\tInforme o id do médico responsável pelo atendimento: ')
        id_pro = input('\tInforme o id do prontuário de atendimento: ')
        grade = input('\tInforme o grau de avaliação do atendimento (I, A, B, M): ')
        obs = input('\tInforme as observações do atendimento: ')
        new_date = input('\tInforme a data do atendimento (YYYY-MM-DD): ')

        try:
            connection = self.getConnection() 
            cursor = connection.cursor()

            cursor.callproc('simulacao_medicina_criar_atendimento', (new_date, grade, obs, id_med, id_pac, id_pro))

            connection.commit()
            connection.close()

            print('Dados criados com sucesso!')
        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass

    def simulateEditMedicalCare(self):
        id_ate = input('\tInforme o id do atendimento: ')
        grade = input('\tInforme o novo grau de avaliação do atendimento (I, A, B, M): ')
        obs = input('\tInforme as novas observações do atendimento: ')
        new_date = input('\tInforme a nova data do atendimento (YYYY-MM-DD): ')

        try:
            connection = self.getConnection() 
            cursor = connection.cursor()

            cursor.callproc('simulacao_medicina_editar_atendimento', (id_ate, new_date, grade, obs))

            connection.commit()
            connection.close()

            print('Dados editados com sucesso!')
        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass
            
    def simulateCreateSample(self):
        id_lab = input('\tInforme o id do laboratório: ')
        id_pac = input('\tInforme o id do paciente: ')
        id_res = input('\tInforme o id do pesquisador: ')
        new_date = input('\tInforme a data da coleta (YYYY-MM-DD): ')
        result = input('\tInforme o resultado (P, N): ')

        try:
            connection = self.getConnection() 
            cursor = connection.cursor()

            cursor.callproc('simulacao_pesquisa_criar_amostra', (new_date, result, id_lab, id_pac, id_res))

            connection.commit()
            connection.close()

            print('Dados criados com sucesso!')
        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass

    def simulateEditSample(self):
        id_sam = input('\tInforme o id da amostra:')
        new_date = input('\tInforme a data da coleta (YYYY-MM-DD): ')
        result = input('\tInforme o resultado (P, N): ')

        try:
            connection = self.getConnection() 
            cursor = connection.cursor()

            cursor.callproc('simulacao_pesquisa_editar_amostra', (id_sam, new_date, result))

            connection.commit()
            connection.close()

            print('Dados editados com sucesso!')
        except Exception as e:
            print("\nAlguma coisa deu errado. Contate o administrador do banco de dados!\n")
            pass
