-- NOT NULL constraint for Payments
ALTER TABLE Payment
MODIFY amount FLOAT NOT NULL;

INSERT INTO Payment (payment_id, amount, payment_date)
VALUES (123456, NULL, TO_DATE('2024-06-18', 'YYYY-MM-DD'));


-- DEFAULT constraint for Trails
ALTER TABLE Trails
MODIFY open_closed DEFAULT 'open';

INSERT INTO Trails (trail_name, trail_id, difficulty_level, location, price)
VALUES ('Nachal Achziv', 21239, 'Moderate', 'Northern District HaZafon', 40);
select * from trails t where t.trail_id = 21239;


-- CHECK constraint for Employee
ALTER TABLE Employees
ADD CONSTRAINT age_check
CHECK (age <= 64);

INSERT INTO Employees (employee_name, employee_id, seniority, contact_info, age)
VALUES ('Josef Smith', 400,40, '054-251-9150', 65);
