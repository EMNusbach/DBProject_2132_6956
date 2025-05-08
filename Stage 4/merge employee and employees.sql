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

commit;
