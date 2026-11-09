# Car Rental Portal - College Demo Setup

This package supports the college setup using Maven + local Apache Tomcat 10.1 + Docker PostgreSQL 16.

## Mode A - Recommended: Maven + local Tomcat + Docker PostgreSQL

1. Open PowerShell in the project folder.
2. Start PostgreSQL:

    docker compose up -d db

3. Build the WAR:

    mvn clean package -DskipTests

4. Deploy the WAR:

    copy /Y target\CarRentalPortal.war "C:\apache-tomcat-10.1.57-windows-x64\apache-tomcat-10.1.57\webapps\ROOT.war"

5. Start Tomcat:

    cd "C:\apache-tomcat-10.1.57-windows-x64\apache-tomcat-10.1.57\bin"
    .\startup.bat

6. Open:

    http://localhost:8080/

Local Tomcat connects to Docker PostgreSQL at localhost:5432.

Database settings:
DB_HOST=localhost
DB_PORT=5432
DB_NAME=car_rental
DB_USER=postgres
DB_PASSWORD=postgres

## Mode B - Full Docker

This runs both PostgreSQL and Tomcat in Docker:

    docker compose up --build

Open:

    http://localhost:8081/

## Default admin

Username: admin
Password: admin123

## Sample user

Email: rahul@gmail.com
Password: 123456

## Reset the Docker database

WARNING: this deletes all Docker database data:

    docker compose down -v
    docker compose up -d db

## PostgreSQL shell

You do not need psql installed on Windows:

    docker exec -it car-rental-db psql -U postgres -d car_rental

## Fresh database

A new PostgreSQL Docker volume loads:
- database/car_rental.sql
- database/sample_data.sql

The fresh schema includes profile_photo, required by the profile-photo feature.
