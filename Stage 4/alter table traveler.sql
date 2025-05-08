-- Alter table customer 

-- Renaming table name to traveler
ALTER TABLE Customers
RENAME TO Traveler;

-- droping columns
ALTER TABLE Traveler
DROP COLUMN traveler_name;

ALTER TABLE Traveler
DROP COLUMN traveler_age;

ALTER TABLE Traveler
DROP COLUMN contact_info;

ALTER TABLE Traveler
DROP COLUMN birth_date;



