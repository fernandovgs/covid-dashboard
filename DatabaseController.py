import psycopg2

class PGDatabase:
    """
    """

    def __init__(self):
        """
        """
        self.connection = None

        try:
            connection = psycopg2.connect(database='COVID-19',
                             user = 'postgres',
                             password = 'postgres',
                             host = '127.0.0.1',
                             port = '5432')

            print('Conectado com o banco de dados!\n\n')
        except Exception as e:
            print('Não foi possível se conectar ao banco de dados!')
            raise e

