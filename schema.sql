/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
	id int primary key,
	name varchar(20) NOT NULL,
	date_of_birth date,
	escape_attempts int,
	neutered bool,
	weight_kg real
);