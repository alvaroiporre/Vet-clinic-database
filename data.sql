/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0, true, 10.23 ),
('Gabumon', '2018-11-15', 2, true, 8 ),
('Pikachu', '2021-01-07', 1, false, 15.04 ),
('Devimon', '2017-05-12', 5, true, 11 );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11 ),
('Plantmon', '2021-11-15', 2, true, -5.7),
('Squirtle', '1993-04-02', 3, false, -12.13),
('Angemon', '2005-06-12', 1, true, -45),
('Boarmon', '2005-06-07', 7, true, 20.4),
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);


/* Insert the following data into the owners table:
    Sam Smith 34 years old.
    Jennifer Orwell 19 years old.
    Bob 45 years old.
    Melody Pond 77 years old.
    Dean Winchester 14 years old.
    Jodie Whittaker 38 years old. */

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

/* Insert the following data into the species table:
    Pokemon
    Digimon */
INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

/* Modify your inserted animals so it includes the species_id value:
    If the name ends in "mon" it will be Digimon
    All other animals are Pokemon */
UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE name NOT LIKE '%mon';


