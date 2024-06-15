ALTER TABLE Employees
ADD CONSTRAINT age_check
CHECK (age <= 64);

INSERT INTO Employees (employee_name, employee_id, seniority, contact_info, age)
VALUES ('Josef Smith', 400,40, '054-251-9150', 65); 


ALTER TABLE Trails
ADD CONSTRAINT price_check
CHECK (price >= 0);


INSERT INTO Trails (trail_name, trail_id, difficulty_level, location, price, open_closed)
VALUES ('Nachal Achziv', 21239, ' Moderate', 'Northern District HaZafon', -5, 'Open'); 


ALTER TABLE Customers
ADD CONSTRAINT phone_starts_with_zero
CHECK (contact_info LIKE '0%');

INSERT INTO Customers (traveler_id, traveler_name, traveler_age, contact_info, number_of_travelers, trip_date)
VALUES (326550, 'Nikki Smith', 15, '453-729-1771', 3,TO_DATE('2023-12-09', 'YYYY-MM-DD')); 
