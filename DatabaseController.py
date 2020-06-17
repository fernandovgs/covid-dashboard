import psycopg2

class PGDatabase:
    """
    """

    def __init__(self):
        """
        """
        self.connection = None
        self.user = ''

        try:
            self.connection = psycopg2.connect(database='COVID-19',
                             user = 'postgres',
                             password = 'postgres',
                             host = '127.0.0.1',
                             port = '5432')

            print('Conectado com o banco de dados!\n\n')
        except Exception as e:
            print('Não foi possível se conectar ao banco de dados!')
            print('Fechando programa...')
            raise e

    """ GETTERS E SETTERS
    """
    def getConnection(self):
        return self.connection

    def setUser(self, user):
        self.user = user

    def getUser(self):
        return self.user

    def loginDatabase(self, login, password):
        cursor = self.getConnection().cursor()

        cursor.callproc('login_banco', (login, password))

        result = cursor.fetchone()

        if result[0] == True:
            print('Usuário {} logado!'.format(login))
            self.setUser(login)
            return True

        return False

    def reportOne(self):
        cursor = self.getConnection().cursor()

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


    def reportTwo(self):
        cursor = self.getConnection().cursor()

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


    def reportThree(self):
        cursor = self.getConnection().cursor()

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

    def reportFour(self):
        cursor = self.getConnection().cursor()

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


    def reportFive(self):
        cursor = self.getConnection().cursor()

        cursor.callproc('historico_laboratorios')

        result = cursor.fetchall()

        for row in result:
            print('------------------')
            print('\tNome: {}'.format(row[0]))            
            print('\tQuantidade de pesquisadores: {}'.format(str(row[1])))
            print('\tEndereço: {}'.format(row[2]))
            print('\tAmostras: {}'.format(row[3]))


    def reportSix(self):
        cursor = self.getConnection().cursor()

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


