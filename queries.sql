/*Queries that provide answers to the questions from all projects.*/
/*Find all animals whose name ends in "mon".*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT * FROM animals WHERE neutered = true;

/*Find all animals not named Gabumon.*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Inside a transaction update the animals table by setting the species 
column to unspecified. Verify that change was made. Then roll back the 
change and verify that the species columns went back to the state before 
the transaction.*/
BEGIN;
UPDATE animals set species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;


/*Inside a transaction:
  - Update the animals table by setting the species column to digimon 
    for all animals that have a name ending in mon.
  - Update the animals table by setting the species column to pokemon 
    for all animals that don't have species already set.
  - Verify that changes were made.
  - Commit the transaction.
  - Verify that changes persist after commit.*/
BEGIN;
UPDATE animals set species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals set species = 'pokemon' WHERE species is null;
SELECT * FROM animals;
COMMIT;

/*
Now, take a deep breath and... Inside a transaction delete all records 
in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists. 
After that, you can start breathing as usual ;)
*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

/*
Inside a transaction:
  - Delete all animals born after Jan 1st, 2022.
  - Create a savepoint for the transaction.
  - Update all animals' weight to be their weight multiplied by -1.
  - Rollback to the savepoint
  - Update all animals' weights that are negative to be their weight multiplied by -1.
  - Commit transaction
*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals set weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals set weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


/*
How many animals are there?
*/
SELECT 'Number of Animals', COUNT(*) FROM animals;

/*
How many animals have never tried to escape?
*/
SELECT 'animals have never tried to escape', COUNT(*) FROM animals
WHERE escape_attempts = 0;

/*
What is the average weight of animals?
*/
SELECT 'Weight average', AVG(weight_kg) FROM animals;

/*
Who escapes the most, neutered or not neutered animals?
*/
SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;

/*
What is the minimum and maximum weight of each type of animal?
*/
SELECT MIN(weight_kg), MAX(weight_kg), species FROM animals GROUP BY species;

/*
What is the average number of escape attempts per animal type of those born between 1990 and 2000?
*/
SELECT AVG(escape_Attempts), species FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- What animals belong to Melody Pond?
SELECT a.name, o.full_name FROM animals a JOIN owners o ON a.owner_id = o.id 
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name, s.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(a.name) FROM species s JOIN animals a ON s.id = a.species_id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name, o.full_name, s.name FROM animals a JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id 
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name, o.full_name FROM animals a JOIN owners o ON a.owner_id = o.id 
WHERE a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT COUNT(a.*), o.full_name FROM animals a RIGHT JOIN owners o ON a.owner_id = o.id 
GROUP BY o.full_name ORDER BY count desc LIMIT 1;

--Who was the last animal seen by William Tatcher?
SELECT a.name, ve.name, vi.visit_date FROM
animals a INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY vi.visit_date DESC
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT DISTINCT(a.name), ve.name FROM animals a
INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
WHERE ve.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT ve.name, s.name FROM vets ve
LEFT JOIN specializations sp ON ve.id = sp.id_vet
LEFT JOIN species s ON sp.id_specie = s.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, ve.name, vi.visit_date FROM animals a
INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
WHERE ve.name = 'Stephanie Mendez'
AND vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT COUNT(vi.id) AS n_visits, a.name FROM animals a
INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
GROUP BY a.name
ORDER BY n_visits DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT a.name, ve.name, vi.visit_date FROM
animals a INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY vi.visit_date asc
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name, a.date_of_birth,
a.escape_attempts, a.neutered, a.weight_kg,
s.name AS specie, o.full_name AS owner, 
ve.name, ve.age, ve.date_of_graduation, vi.visit_date
FROM animals a 
INNER JOIN visits vi ON a.id = vi.id_animal
INNER JOIN vets ve ON vi.id_vet = ve.id
INNER JOIN species s ON a.species_id = s.id
INNER JOIN owners o ON o.id = a.owner_id
ORDER BY vi.visit_date DESC;


--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS visits_without_specialization
FROM visits vi
JOIN animals a ON vi.id_animal = a.id
JOIN vets ve ON vi.id_vet = ve.id
LEFT JOIN specializations sp ON ve.id = sp.id_vet AND a.species_id = sp.id_specie
WHERE sp.id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name, COUNT(*) AS visit_count
FROM visits vi
JOIN animals a ON vi.id_animal = a.id
JOIN species s ON a.species_id = s.id
JOIN vets ve ON ve.id = vi.id_vet
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;
-- The following queries will take to much time
explain analyze SELECT COUNT(*) FROM visits where id_animal = 4;
explain analyze SELECT * FROM visits where id_vet = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';