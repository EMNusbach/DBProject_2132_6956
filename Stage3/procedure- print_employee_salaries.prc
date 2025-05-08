--select * from Employee_at_trail;
--select * from employee_at_trail where employee_id = 1 AND TO_CHAR(work_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM');

CREATE OR REPLACE PROCEDURE print_employee_salaries(employee_in IN Employees.employee_id%TYPE) IS
    -- Declare variables to hold the total salary and total days worked
    v_total_salary NUMBER := 0; -- Initialize total salary
    v_total_days_worked NUMBER := 0; -- Initialize total days worked
    v_first_row BOOLEAN := TRUE; -- Flag to print employee_id only once   

 -- Declare a cursor to hold the employee salary data
    CURSOR emp_salaries IS
        SELECT employee_id, 
               job, 
               COUNT(work_date) AS days_worked,
               CASE job
                   WHEN 'cleaner' THEN COUNT(work_date) * (70 * 9)
                   WHEN 'security guard' THEN COUNT(work_date) * (100 * 9)
                   WHEN 'receptionist' THEN COUNT(work_date) * (40 * 9)
                   ELSE 0 -- Default case for other job types
               END AS salary
        FROM Employee_At_Trail
        WHERE employee_id = employee_in
        AND TO_CHAR(work_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')
        GROUP BY employee_id, job;
    
BEGIN
    -- Use a FOR loop to fetch rows from the cursor
    FOR emp_rec IN emp_salaries LOOP
        -- Print the employee ID once
        IF v_first_row THEN
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.employee_id);
            v_first_row := FALSE;
        END IF;
        -- Print the job, days worked, and salary
        DBMS_OUTPUT.PUT_LINE('Job: ' || emp_rec.job || 
                             ', Days Worked: ' || emp_rec.days_worked || 
                             ', Salary: ' || emp_rec.salary);
        -- Accumulate the total salary and total days worked
        v_total_salary := v_total_salary + emp_rec.salary;
        v_total_days_worked := v_total_days_worked + emp_rec.days_worked;
    END LOOP;
    
    -- Print the total salary and total days worked
    DBMS_OUTPUT.PUT_LINE('Total Salary: ' || v_total_salary);
    DBMS_OUTPUT.PUT_LINE('Total Days Worked: ' || v_total_days_worked);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred while retrieving salaries: ' || SQLERRM);
END print_employee_salaries;
/
