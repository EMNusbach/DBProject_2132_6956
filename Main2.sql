-- Main block to receive user input and call appropriate function/procedure
DECLARE
    -- Variable to hold the user's choice
    v_choice NUMBER;
    -- Ref Cursor to get results from the function
    v_ref_cursor SYS_REFCURSOR;
    -- Variables to hold employee ID and traveler ID
    v_employee_id Employees.employee_id%TYPE;
    v_traveler_id Customers.traveler_id%TYPE;
    -- Variables to hold the fetched data from the cursor
    v_employee_name Employees.employee_name%TYPE;
    v_work_date Employee_at_trail.work_date%TYPE;
    v_job Employee_at_trail.job%TYPE;
    v_trail_name Trails.trail_name%TYPE;
    v_location Trails.location%TYPE;
    -- Flag to check if the employee name has been printed
    v_name_printed BOOLEAN := FALSE;

BEGIN
    -- Prompt user to choose an option
    DBMS_OUTPUT.PUT_LINE('Enter 1 to get employee trails');
    DBMS_OUTPUT.PUT_LINE('Enter 2 to calculate total payment for a traveler');
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
    v_choice := &choice;

    -- Process the user's choice
    IF v_choice = 1 THEN
        -- Get employee ID from the user
        v_employee_id := &employee_id;

        -- Call the function to get the employee trails
        v_ref_cursor := GetEmployeeTrails(v_employee_id);

        -- Check if the cursor is null (meaning no trails found)
        IF v_ref_cursor IS NOT NULL THEN
            -- Fetch and process the results from the Ref Cursor
            LOOP
                FETCH v_ref_cursor INTO v_employee_name, v_work_date, v_job, v_trail_name, v_location;
                EXIT WHEN v_ref_cursor%NOTFOUND;

                -- Print the employee name only once
                IF NOT v_name_printed THEN
                    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_employee_name);
                    v_name_printed := TRUE;
                END IF;

                -- Print the trail details
                DBMS_OUTPUT.PUT_LINE('Work Date: ' || v_work_date);
                DBMS_OUTPUT.PUT_LINE('Job: ' || v_job);
                DBMS_OUTPUT.PUT_LINE('Trail Name: ' || v_trail_name);
                DBMS_OUTPUT.PUT_LINE('Location: ' || v_location);
            END LOOP;

            -- Close the Ref Cursor
            CLOSE v_ref_cursor;
        ELSE
            DBMS_OUTPUT.PUT_LINE('No trails found for employee with ID ' || v_employee_id);
        END IF;

    ELSIF v_choice = 2 THEN
        -- Get traveler ID from the user
        v_traveler_id := &traveler_id;

        -- Call the procedure to calculate total payment for the traveler
        TotalPayment(v_traveler_id);

    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please enter 1 or 2.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
