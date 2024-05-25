CREATE TABLE Employees
(
  employee_name VARCHAR(255) NOT NULL,
  employee_id NUMERIC(6) NOT NULL,
  seniority NUMERIC(3) NOT NULL,
  contact_info VARCHAR(255) NOT NULL,
  PRIMARY KEY (employee_id)
);

CREATE TABLE Trails
(
  trail_name VARCHAR(255) NOT NULL,
  trail_id NUMERIC(6) NOT NULL,
  difficulty_level VARCHAR(50) NOT NULL,
  location VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  PRIMARY KEY (trail_id)
);

CREATE TABLE Biking_Trails
(
  length NUMERIC(5) NOT NULL,
  terrain_description VARCHAR(255),
  rental_on_site VARCHAR(50) NOT NULL,
  trail_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (trail_id),
  FOREIGN KEY (trail_id) REFERENCES Trails(trail_id)
);

CREATE TABLE Hiking_Trails
(
  duration FLOAT,
  family_friendly VARCHAR(50) NOT NULL,
  accessibility_info VARCHAR(255) NOT NULL,
  trail_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (trail_id),
  FOREIGN KEY (trail_id) REFERENCES Trails(trail_id)
);

CREATE TABLE Employee_at_trail
(
  employee_id NUMERIC(6) NOT NULL,
  trail_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (employee_id, trail_id),
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
  FOREIGN KEY (trail_id) REFERENCES Trails(trail_id)
);

CREATE TABLE Customers_payment
(
  payment_id NUMERIC(6) NOT NULL,
  traveler_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
  FOREIGN KEY (traveler_id) REFERENCES Customers(traveler_id)
);

CREATE TABLE Payment
(
  payment_id NUMERIC(6) NOT NULL,
  amount FLOAT NOT NULL,
  payment_date DATE NOT NULL,
  PRIMARY KEY (payment_id)
);

CREATE TABLE Customers
(
  traveler_id NUMERIC(6) NOT NULL,
  traveler_name VARCHAR(255) NOT NULL,
  traveler_age NUMERIC(3),
  contact_info INT,
  number_of_travelers NUMERIC(4) NOT NULL,
  trip_date DATE NOT NULL,
  PRIMARY KEY (traveler_id)
);

CREATE TABLE Bikers_on_trail
(
  traveler_id NUMERIC(6) NOT NULL,
  trail_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (traveler_id, trail_id),
  FOREIGN KEY (traveler_id) REFERENCES Customers(traveler_id),
  FOREIGN KEY (trail_id) REFERENCES Biking_Trails(trail_id)
);

CREATE TABLE Hikers_on_trail
(
  trail_id NUMERIC(6) NOT NULL,
  traveler_id NUMERIC(6) NOT NULL,
  PRIMARY KEY (trail_id, traveler_id),
  FOREIGN KEY (trail_id) REFERENCES Hiking_STrails(trail_id),
  FOREIGN KEY (traveler_id) REFERENCES Customers(traveler_id)
);
