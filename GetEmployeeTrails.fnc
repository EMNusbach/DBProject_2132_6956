CREATE OR REPLACE FUNCTION GetEmployeeTrails(employee_id_in IN NUMBER)
RETURN SYS_REFCURSOR
IS
    cur_result SYS_REFCURSOR;
    trail_count NUMBER;
BEGIN
    -- Count the number of trails for the given employee
    SELECT COUNT(*)
    INTO trail_count
    FROM Employee_at_trail
    WHERE employee_id = employee_id_in;

    -- Check if there are no trails
    IF trail_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No trails found for employee with ID ' || employee_id_in);
        RETURN NULL;
    ELSE
        OPEN cur_result FOR
            SELECT e.employee_name, et.work_date, et.job, t.trail_name, t.location
            FROM Employees e
            JOIN Employee_at_trail et ON e.employee_id = et.employee_id
            JOIN Trails t ON et.trail_id = t.trail_id
            WHERE e.employee_id = employee_id_in;
    END IF;

    RETURN cur_result;
END;
/
