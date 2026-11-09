FROM postgres:16
COPY car_rental.sql /docker-entrypoint-initdb.d/01-car_rental.sql
COPY sample_data.sql /docker-entrypoint-initdb.d/02-sample_data.sql
