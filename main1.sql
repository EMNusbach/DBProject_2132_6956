-- Main block to receive user input and call appropriate function/procedure
DECLARE
    -- Variable to hold the user's choice
    v_choice NUMBER;
    -- Variables to hold trail rating details
    v_trail_id trails.trail_id%TYPE;
    v_mean_rating NUMBER;
    v_highest_rating NUMBER;
    v_lowest_rating NUMBER;
    -- Ref Cursor to get results from the function
    v_ref_cursor SYS_REFCURSOR;
    -- Variable to hold employee ID for salary procedure
    v_employee_id Employees.employee_id%TYPE;

BEGIN
    -- Prompt user to choose an option
    DBMS_OUTPUT.PUT_LINE('Enter 1 to get trail mean rating');
    DBMS_OUTPUT.PUT_LINE('Enter 2 to print employee salaries');
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
    v_choice := &choice;

    -- Process the user's choice
    IF v_choice = 1 THEN
        -- Get trail ID from the user
        v_trail_id := &trail_id;
        
        -- Call the function to get the trail mean rating
        v_ref_cursor := get_trail_mean_rating(v_trail_id);

        -- Fetch and process the results from the Ref Cursor
        LOOP
            FETCH v_ref_cursor INTO v_trail_id, v_mean_rating, v_highest_rating, v_lowest_rating;
            EXIT WHEN v_ref_cursor%NOTFOUND;

            -- Print the details for verification
            DBMS_OUTPUT.PUT_LINE('Trail ID: ' || v_trail_id);
            DBMS_OUTPUT.PUT_LINE('Mean Rating: ' || v_mean_rating);
            DBMS_OUTPUT.PUT_LINE('Highest Rating: ' || v_highest_rating);
            DBMS_OUTPUT.PUT_LINE('Lowest Rating: ' || v_lowest_rating);
        END LOOP;

        -- Close the Ref Cursor
        CLOSE v_ref_cursor;
        
    ELSIF v_choice = 2 THEN
        -- Get employee ID from the user
        v_employee_id := &employee_id;
        
        -- Call the procedure to print employee salaries
        print_employee_salaries(v_employee_id);
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please enter 1 or 2.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
