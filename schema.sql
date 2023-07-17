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

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets(
	id serial not null,
	name varchar(20),
	age int,
	date_of_graduation date,
	PRIMARY KEY(id)
);

-- There is a many-to-many relationship between the tables species and vets: 
-- a vet can specialize in multiple species, and a species can have multiple 
-- vets specialized in it. Create a "join table" called specializations 
-- to handle this relationship.
CREATE TABLE specializations(
	id serial not null,
	id_vet int, 
	id_specie int,
	PRIMARY KEY (id),
	CONSTRAINT FK_VET FOREIGN KEY (id_vet) REFERENCES vets(id),
	CONSTRAINT FK_SPECIE FOREIGN KEY (id_specie) REFERENCES species(id)
);

-- There is a many-to-many relationship between the tables animals and vets: 
-- an animal can visit multiple vets and one vet can be visited by multiple 
-- animals. Create a "join table" called visits to handle this relationship, 
-- it should also keep track of the date of the visit.
CREATE TABLE visits(
	id serial not null,
	id_animal int, 
	id_vet int,
	visit_date date,
	PRIMARY KEY (id),
	CONSTRAINT FK_VET FOREIGN KEY (id_vet) REFERENCES vets(id),
	CONSTRAINT FK_SPECIE FOREIGN KEY (id_animal) REFERENCES animals(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Add indexes
CREATE INDEX ID_ANIMAL ON visits(id_animal);
CREATE INDEX ID_VET ON visits(id_vet);
CREATE INDEX EMAIL ON owners(email);