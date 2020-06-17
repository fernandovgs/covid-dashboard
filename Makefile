## Call superuser
sudo-create-database:
	sudo PGPASSWORD=postgres createdb -h localhost -p 5432 -U postgres COVID-19
sudo-create-schema:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/script.sql
sudo-generate-data:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/carga.sql
sudo-generate-login:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/login_table.sql
sudo-reports-procedures:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/reports_procedures.sql
sudo-generate-simulations:
	sudo PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/simulations.sql	
sudo-db: sudo-create-database sudo-create-schema sudo-generate-data sudo-generate-login sudo-reports-procedures sudo-generate-simulations

## With superuser
create-database:
	PGPASSWORD=postgres createdb -h localhost -p 5432 -U postgres COVID-19
create-schema:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/script.sql
generate-data:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/carga.sql
generate-login:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/login_table.sql
reports-procedures:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/reports_procedures.sql	
generate-simulations:
	PGPASSWORD=postgres psql --host=localhost --port=5432 -U postgres -d COVID-19 < db/simulations.sql	
db: create-database create-schema generate-data generate-login reports-procedures generate-simulations
