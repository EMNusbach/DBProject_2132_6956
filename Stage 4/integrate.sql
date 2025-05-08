--Alter table person

--adding to person a birth date
ALTER TABLE PERSON
ADD (birth_date DATE);

UPDATE PERSON
SET birth_date = TO_DATE(
                   TRUNC(
                     DBMS_RANDOM.VALUE(TO_CHAR(DATE '1940-01-01','J'),
                                       TO_CHAR(DATE '2024-12-31','J'))
                   ),'J');
                   


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



-- Alter table donor

--removing columns from donor table 
ALTER TABLE DONOR
DROP COLUMN EVENTID;

ALTER TABLE DONOR
DROP COLUMN PERSONID;


--Alter table employee

-- Insert employees into the PERSON table
BEGIN

  FOR rec IN (SELECT EMPLOYEE_NAME, EMPLOYEE_ID, CONTACT_INFO, AGE FROM EMPLOYEES) LOOP
    -- Split the employee name into first and last name
    DECLARE
      first_name VARCHAR2(255);
      last_name  VARCHAR2(255);
      birth_date DATE;
      nine_digit_id NUMBER;
    BEGIN
      first_name := SUBSTR(rec.EMPLOYEE_NAME, 1, INSTR(rec.EMPLOYEE_NAME, ' ') - 1);
      last_name := SUBSTR(rec.EMPLOYEE_NAME, INSTR(rec.EMPLOYEE_NAME, ' ') + 1);
      birth_date := ADD_MONTHS(TRUNC(SYSDATE, 'YEAR'), -12 * rec.AGE) + DBMS_RANDOM.VALUE(1, 365);
      nine_digit_id := 100000000 + rec.EMPLOYEE_ID;
      
      INSERT INTO PERSON (PERSONID, FIRSTNAME, LASTNAME, ADDRESS, EMAIL, PHONENUMBER, BIRTH_DATE)
      VALUES (nine_digit_id, first_name, last_name, random_address, generate_email(first_name, last_name), rec.CONTACT_INFO, birth_date);
    END;
  END LOOP;
END;

--merge employee and employees
BEGIN
  FOR rec IN (SELECT e.EMPLOYEE_ID, e.SENIORITY, t.JOB
              FROM Employees e
              JOIN Employee_at_trail t
              ON e.EMPLOYEE_ID = t.employee_id) LOOP
    DECLARE
      nine_digit_id NUMBER(9);
      hourly_wage NUMBER(5,2);
      workhours NUMBER(2);
    BEGIN
      nine_digit_id := 100000000 + rec.EMPLOYEE_ID;
      hourly_wage := ROUND(DBMS_RANDOM.VALUE(10, 50), 2); -- Random hourly wage between 10.00 and 50.00
      workhours := ROUND(DBMS_RANDOM.VALUE(20, 40));      -- Random work hours between 20 and 40

      -- Check if personid already exists
      BEGIN
        INSERT INTO Employee (personid, position, hourlywage, seniority, workhours)
        VALUES (nine_digit_id, rec.JOB, hourly_wage, rec.SENIORITY, workhours);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          -- Handle duplicate personid by updating the existing record (if necessary)
          UPDATE Employee
          SET position = rec.JOB,
              hourlywage = hourly_wage,
              seniority = rec.SENIORITY,
              workhours = workhours
          WHERE personid = nine_digit_id;
      END;
      
    END;
  END LOOP;
END;

--drop table employees
DROP table employees;



-- Alter table event

--removing columns from event table 
ALTER TABLE EVENT
DROP COLUMN donorid_;

ALTER TABLE EVENT
DROP COLUMN employeeid;



-- Alter table payment

--adding 2 columns to the payment table
ALTER TABLE payment
ADD (number_of_payments NUMBER(3),
     payment_method VARCHAR2(20));
	 
--generting random data for payment table
BEGIN
  FOR rec IN (SELECT ROWID, number_of_payments, payment_method FROM payment) LOOP
    DECLARE
      random_payments NUMBER(3);
      random_method VARCHAR2(20);
    BEGIN
      -- Generate random number of payments between 1 and 10
      random_payments := ROUND(DBMS_RANDOM.VALUE(1, 10));

      -- Generate random payment method
      random_method := CASE ROUND(DBMS_RANDOM.VALUE(1, 4))
                         WHEN 1 THEN 'Credit Card'
                         WHEN 2 THEN 'Debit Card'
                         WHEN 3 THEN 'PayPal'
                         WHEN 4 THEN 'Bank Transfer'
                       END;

      -- Update the payment table with random values
      UPDATE payment
      SET number_of_payments = random_payments,
          payment_method = random_method
      WHERE ROWID = rec.ROWID;
    END;
  END LOOP;
END;



-- Alter table donation

-- insert donation data into payment
BEGIN
  FOR rec IN (SELECT donationid, numofpayments, amount, donationdate, paymentmethod FROM donation) LOOP
    BEGIN
      -- Insert data into payment table, using donationid as payment_id
      INSERT INTO payment (payment_id, number_of_payments, amount, payment_date, payment_method)
      VALUES (rec.donationid, rec.numofpayments, rec.amount, rec.donationdate, rec.paymentmethod);
    END;
  END LOOP;
END;

-- changing the column name from donorid to person_id
ALTER TABLE donation RENAME COLUMN donorid TO person_id;
ALTER TABLE donation RENAME COLUMN donationid TO payment_id;

--droping the overlapping columns from the donation table
ALTER TABLE donation DROP COLUMN numofpayments;
ALTER TABLE donation DROP COLUMN amount;
ALTER TABLE donation DROP COLUMN donationdate;
ALTER TABLE donation DROP COLUMN paymentmethod;

--adding a foreign key
ALTER TABLE donation
ADD CONSTRAINT fk_payment_id
FOREIGN KEY (payment_id)
REFERENCES payment(payment_id);



--Alter table employee_at_trail

--removing columns from employee_at_trail table 
ALTER TABLE Employee_at_trail
DROP COLUMN work_date;

ALTER TABLE Employee_at_trail
DROP COLUMN job;

