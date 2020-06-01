create-database:
	sudo PGPASSWORD=postgres createdb -h localhost -p 5432 -U postgres COVID-19
create-schema:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < script.sql
generate-data:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < carga.sql
db: create-database create-schema generate-data