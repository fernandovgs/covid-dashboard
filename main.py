from DatabaseController import *

db = PGDatabase()

print('****COVID-19 DASHBOARD - OMS****\n')

print('Primeiro, realize o login (entre com login=0 para fechar o aplicativo):')

loginSuccess = False
login = ''

while loginSuccess == False:
	login = input('\tLogin: ')

	if login == '0':
		break

	senha = input('\tSenha: ')

	loginSuccess = db.loginDatabase(login, senha)

if login != '0':
	op = '-1'
	print('\n---------------\n')
	while op != '0':
		print('\n****TELA PRINCIPAL****\n')
		print('\t1 - Dashboard')
		print('\t2 - Relatórios')
		print('\t3 - Simulações')
		print('\t0 - Sair')
		op = input('\n\tOpção: ')

		if op == '1':
			print('\n***DASHBOARD***\n')
		elif op == '2':
			print('\n***RELATÓRIOS***\n')
		elif op == '3':
			print('\n***SIMULAÇÕES***\n')
		elif op == '0':
			print('Saindo do programa...')
		else:
			print('Opção inválida!')
