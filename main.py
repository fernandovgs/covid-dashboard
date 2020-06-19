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
            if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                print('\t2 - Histórico dos Hospitais')
            if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                print('\t3 - Histórico de Atendimento dos municípios')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t4 - Histórico de Amostras')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t5 - Histórico de Laboratórios')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t6 - Histórico de Pesquisadores')

            opRelatorios = input('\n\tOpção: ')

            if opRelatorios == '1':
                db.reportOne()
            elif opRelatorios == '2':
                if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                    db.reportTwo()
                else:
                    print('Opção inválida!')
            elif opRelatorios == '3':
                if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                    db.reportThree()
                else:
                    print('Opção inválida!')
            elif opRelatorios == '4':
                if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                    db.reportFour()
                else:
                    print('Opção inválida!')
            elif opRelatorios == '5':
                if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                    db.reportFive()
                else:
                    print('Opção inválida!')
            elif opRelatorios == '6':
                if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                    db.reportSix()
                else:
                    print('Opção inválida!')
            else:
                print('Opção inválida!')

        elif op == '3':
            print('\n***SIMULAÇÕES***\n')
            if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                print('\t1 - Novo prontuário')
            if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                print('\t2 - Novo atendimento')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t3 - Alteração de atendimento')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t4 - Nova amostra')
            if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                print('\t5 - Alteração de amostra')
            print('\t6 - Restaurar valores')

            opSim = input('\n\tOpção: ')


            if opSim == '1':
                if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                    db.simulateCreateMedicalRecord()
                else:
                    print('Opção inválida!')
            elif opSim == '2':
                if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                    db.simulateCreateMedicalCare()
                else:
                    print('Opção inválida!')
            elif opSim == '3':
                if db.getRole() == ADMIN or db.getRole() == MEDICINE:
                    db.simulateEditMedicalCare()
                else:
                    print('Opção inválida!')
            elif opSim == '4':
                if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                    db.simulateCreateSample()
                else:
                    print('Opção inválida!')
            elif opSim == '5':
                if db.getRole() == ADMIN or db.getRole() == RESEARCH:
                    db.simulateEditSample()
                else:
                    print('Opção inválida!')
            elif opSim == '6':
                db.restoreSimulations()
            else:
                print('Opção inválida!')
                

        elif op == '0':
            db.destroySimulations()
        else:
            print('Opção inválida!')

    print('Fechando programa...')
