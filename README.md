#COVID DASHBOARD

## Introdução

Trabalho realizado durante a disciplina de Laboratório de Bases de Dados - SCC0541, oferecida ao curso de Sistemas de Informação na USP de São Carlos. A ideia é simular um programa fictício encomendado pela OMS que gerencia dados relacionados à pandemia do COVID-19, como hospitais, leitos disponíveis/ocupados, testes em pacientes, entre outras funcionalidades.
---
## Dependências
O programa utiliza o SGBD PostgreSQL. <TODO: mini-tutorial com as dependências>

## Setup do Banco de Dados
Uma vez que as dependências estejam devidamente instaladas, deve-se utilizar os arquivos .sql para criação do banco de dados e inserção da carga.
### Setup do Banco de Dados - Linux
Deve-se utilizar os comandos disponíveis no Makefile. Note que há duas maneiras de se chamar os scripts: através do super usuário ou utilizando os scripts que utilizam o comando ```sudo```. Portanto, qualquer um dos dois scripts do makefile abaixo é válido, a diferença está no fato do ```sudo-db``` pedir a senha de super usuário. **Só é necessário utilizar um deles.**

```
$ make sudo-db
$ make db
```

Caso queira rodar cada script SQL individualmente, basta abrir o arquivo ```Makefile``` e utilizar os comandos descritos.