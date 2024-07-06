CREATE OR REPLACE FUNCTION get_trail_mean_rating(p_trail_id IN trails.trail_id%TYPE)
RETURN SYS_REFCURSOR
IS
    -- Variables to hold rating details
    v_sum_rating NUMBER := 0;
    v_count_rating NUMBER := 0;
    v_mean_rating NUMBER;
    v_highest_rating NUMBER := 0;
    v_lowest_rating NUMBER := 5; -- Assuming rating scale is 1 to 5
    
    -- Ref Cursor to return details
    v_ref_cursor SYS_REFCURSOR;

BEGIN
    -- Calculate the sum, count, highest, and lowest rating from Hikers_on_trail
    FOR rec IN (SELECT rating FROM Hikers_on_trail WHERE trail_id = p_trail_id) LOOP
        v_sum_rating := v_sum_rating + rec.rating;
        v_count_rating := v_count_rating + 1;
        
        IF rec.rating > v_highest_rating THEN
            v_highest_rating := rec.rating;
        END IF;
        
        IF rec.rating < v_lowest_rating THEN
            v_lowest_rating := rec.rating;
        END IF;
    END LOOP;
    
    -- Calculate the sum, count, highest, and lowest rating from Bikers_on_trail
    FOR rec IN (SELECT rating FROM Bikers_on_trail WHERE trail_id = p_trail_id) LOOP
        v_sum_rating := v_sum_rating + rec.rating;
        v_count_rating := v_count_rating + 1;
        
        IF rec.rating > v_highest_rating THEN
            v_highest_rating := rec.rating;
        END IF;
        
        IF rec.rating < v_lowest_rating THEN
            v_lowest_rating := rec.rating;
        END IF;
    END LOOP;

    -- Calculate the mean rating
    IF v_count_rating > 0 THEN
        v_mean_rating := CEIL(v_sum_rating / v_count_rating); -- Round up to the nearest integer
    ELSE
        v_mean_rating := NULL;
    END IF;

    -- Open a REF CURSOR to return the trail details
    OPEN v_ref_cursor FOR
    SELECT p_trail_id AS trail_id, 
           v_mean_rating AS mean_rating, 
           v_highest_rating AS highest_rating, 
           v_lowest_rating AS lowest_rating
    FROM DUAL;

    RETURN v_ref_cursor;

EXCEPTION
    -- Handle the case where no ratings are found for the given trail_id
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the given trail ID.');
        RETURN NULL;
    -- Handle other unexpected errors
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred while calculating the mean rating: ' || SQLERRM);
        RETURN NULL;
END get_trail_mean_rating;
/
