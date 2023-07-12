/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
	id SERIAL NOT NULL,
	name varchar(20) NOT NULL,
	date_of_birth date,
	escape_attempts int,
	neutered bool,
	weight_kg real,
    PRIMARY KEY(id)
);
/*
    Add a new column species
*/
ALTER TABLE animals ADD species varchar(20);

/* Create a table named owners with the following columns:
    id: integer (set it as autoincremented PRIMARY KEY)
    full_name: string
    age: integer */
CREATE TABLE owners(
	id serial not null,
	full_name varchar(60),
	age int,
	PRIMARY KEY(id)
);

/* Create a table named species with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string */
CREATE TABLE species(
	id serial not null,
	name varchar(20),
	PRIMARY KEY(id)
);

/* Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY
Remove column species
Add column species_id which is a foreign key referencing species table
Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id int;
ALTER TABLE animals
ADD CONSTRAINT FK_SPECIES FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id int;
ALTER TABLE animals
ADD CONSTRAINT FK_OWNER FOREIGN KEY(owner_id) REFERENCES owners(id);
