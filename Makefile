## Call superuser
sudo-create-database:
	sudo PGPASSWORD=postgres createdb -h localhost -p 5432 -U postgres COVID-19
sudo-create-schema:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < script.sql
sudo-generate-data:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < carga.sql
sudo-generate-login:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < login_table.sql
sudo-db: sudo-create-database sudo-create-schema sudo-generate-data sudo-generate-login

## With superuser
create-database:
	PGPASSWORD=postgres createdb -h localhost -p 5432 -U postgres COVID-19
create-schema:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < script.sql
generate-data:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < carga.sql
generate-login:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < login_table.sql
db: create-database create-schema generate-data

