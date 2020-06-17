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

