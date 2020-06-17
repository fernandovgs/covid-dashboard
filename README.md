#COVID DASHBOARD

## Introdução

Trabalho realizado durante a disciplina de Laboratório de Bases de Dados - SCC0541, oferecida ao curso de Sistemas de Informação na USP de São Carlos. A ideia é simular um programa fictício encomendado pela OMS que gerencia dados relacionados à pandemia do COVID-19, como hospitais, leitos disponíveis/ocupados, testes em pacientes, entre outras funcionalidades.
---
## Dependências
O programa utiliza o SGBD PostgreSQL para controle dos dados, e para a interface, utiliza-se a linguagem Python na versão 3, com a biblioteca *psycopg2*.

### Instalação das dependências - Ubuntu
Para baixar o PostgreSQL, basta utilizar os seguintes comandos:
```
sudo apt update
sudo apt install postgresql-client
```

Para baixar o python 3 e a biblioteca citada, utilize os comandos:
```
sudo apt update
sudo apt install python3
sudo apt install psycopg2
```

Pronto! Todas as dependências estão instaladas.

## Setup do Banco de Dados
Uma vez que as dependências estejam devidamente instaladas, deve-se utilizar os arquivos .sql para criação do banco de dados e inserção da carga.
### Setup do Banco de Dados - Ubuntu
Deve-se utilizar os comandos disponíveis no Makefile. Note que há duas maneiras de se chamar os scripts: através do super usuário ou utilizando os scripts que utilizam o comando ```sudo```. Portanto, qualquer um dos dois scripts do makefile abaixo é válido, a diferença está no fato do ```sudo-db``` pedir a senha de super usuário. **Só é necessário utilizar um deles.**

```
$ make sudo-db
$ make db
```

Caso queira rodar cada script SQL individualmente, basta abrir o arquivo ```Makefile``` e utilizar os comandos descritos.

## Setup - Python
Podemos rodar diretamente o arquivo ```main.py``` na pasta em que o mesmo se encontra. Lembrando que o banco de dados deve estar configurado conforme as instruções indicadas acima.

### Setup - Python - Ubuntu
Utilize o seguinte comando:
```
python3 main.py
```

Pronto! O programa está funcionando.

