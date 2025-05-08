CREATE OR REPLACE FUNCTION get_trail_mean_rating(p_trail_id IN trails.trail_id%TYPE)
RETURN trail_rating_details
IS
    -- Variables to hold rating details
    v_sum_rating NUMBER := 0;
    v_count_rating NUMBER := 0;
    v_mean_rating NUMBER;
    v_highest_rating NUMBER := 0;
    v_lowest_rating NUMBER := 5; -- Assuming rating scale is 1 to 5
    
    -- Record type to hold fetched ratings
    TYPE rating_record IS RECORD (
        rating NUMBER
    );
    trail_rating_rec rating_record;
    
    -- Variable to hold the result
    v_trail_rating_details trail_rating_details;

    -- Cursor for fetching ratings from Hikers_on_trail and Bikers_on_trail
    CURSOR c_hikers IS SELECT rating FROM Hikers_on_trail WHERE trail_id = p_trail_id;
    CURSOR c_bikers IS SELECT rating FROM Bikers_on_trail WHERE trail_id = p_trail_id;

BEGIN
    -- Calculate the sum, count, highest, and lowest rating from Hikers_on_trail
    OPEN c_hikers;
    LOOP
        FETCH c_hikers INTO trail_rating_rec;
        EXIT WHEN c_hikers%NOTFOUND;
        
        v_sum_rating := v_sum_rating + trail_rating_rec.rating;
        v_count_rating := v_count_rating + 1;
        
        IF trail_rating_rec.rating > v_highest_rating THEN
            v_highest_rating := trail_rating_rec.rating;
        END IF;
        
        IF trail_rating_rec.rating < v_lowest_rating THEN
            v_lowest_rating := trail_rating_rec.rating;
        END IF;
    END LOOP;
    CLOSE c_hikers;
    
    -- Calculate the sum, count, highest, and lowest rating from Bikers_on_trail
    OPEN c_bikers;
    LOOP
        FETCH c_bikers INTO trail_rating_rec;
        EXIT WHEN c_bikers%NOTFOUND;
        
        v_sum_rating := v_sum_rating + trail_rating_rec.rating;
        v_count_rating := v_count_rating + 1;
        
        IF trail_rating_rec.rating > v_highest_rating THEN
            v_highest_rating := trail_rating_rec.rating;
        END IF;
        
        IF trail_rating_rec.rating < v_lowest_rating THEN
            v_lowest_rating := trail_rating_rec.rating;
        END IF;
    END LOOP;
    CLOSE c_bikers;

    -- Calculate the mean rating
    IF v_count_rating > 0 THEN
        v_mean_rating := CEIL(v_sum_rating / v_count_rating); -- Round up to the nearest integer
    ELSE
        v_mean_rating := NULL;
    END IF;

    -- Create the trail rating details object
    v_trail_rating_details := trail_rating_details(p_trail_id, v_mean_rating, v_highest_rating, v_lowest_rating);

    -- Print the trail rating details
    DBMS_OUTPUT.PUT_LINE('Trail ID: ' || p_trail_id);
    DBMS_OUTPUT.PUT_LINE('Mean Rating: ' || v_mean_rating);
    DBMS_OUTPUT.PUT_LINE('Highest Rating: ' || v_highest_rating);
    DBMS_OUTPUT.PUT_LINE('Lowest Rating: ' || v_lowest_rating);

    RETURN v_trail_rating_details;

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
