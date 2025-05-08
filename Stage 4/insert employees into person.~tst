PL/SQL Developer Test script 3.0
21
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
3
result
0
-5
first_name
0
-5
last_name
0
-5
0
