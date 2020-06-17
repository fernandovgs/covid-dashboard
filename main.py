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
			db.showDashboard()
		elif op == '2':
			print('\n***RELATÓRIOS***\n')
			print('\t1 - Histórico Pessoal')
			print('\t2 - Histórico dos Hospitais')
			print('\t3 - Histórico de Atendimento dos municípios')
			print('\t4 - Histórico de Amostras')
			print('\t5 - Histórico de Laboratórios')
			print('\t6 - Histórico de Pesquisadores')

			opRelatorios = input('\n\tOpção: ')

			if opRelatorios == '1':
				db.reportOne()
			elif opRelatorios == '2':
				db.reportTwo()
			elif opRelatorios == '3':
				db.reportThree()
			elif opRelatorios == '4':
				db.reportFour()
			elif opRelatorios == '5':
				db.reportFive()
			elif opRelatorios == '6':
				db.reportSix()

		elif op == '3':
			print('\n***SIMULAÇÕES***\n')
		elif op == '0':
			print('Saindo do programa...')
		else:
			print('Opção inválida!')
