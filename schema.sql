/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
CREATE TABLE animals (
	id int primary key,
	name varchar(20) NOT NULL,
	date_of_birth date,
	escape_attempts int,
	neutered bool,
	weight_kg real
);