CREATE OR REPLACE NONEDITIONABLE PROCEDURE TotalPayment(traveler_id_in IN NUMBER)
IS
    CURSOR trail_prices IS
        SELECT t.price, c.number_of_travelers
        FROM Customers c
        JOIN Bikers_on_trail bot ON c.traveler_id = bot.traveler_id
        JOIN Trails t ON bot.trail_id = t.trail_id
        WHERE c.traveler_id = traveler_id_in
        UNION ALL
        SELECT t.price, c.number_of_travelers
        FROM Customers c
        JOIN Hikers_on_trail hot ON c.traveler_id = hot.traveler_id
        JOIN Trails t ON hot.trail_id = t.trail_id
        WHERE c.traveler_id = traveler_id_in;

    total_payment NUMBER := 0;
    trail_rec trail_prices%ROWTYPE;
    trail_count NUMBER := 0;  -- Counter for the number of trails the traveler has participated in
    customer_name VARCHAR2(100);  -- Variable to hold the customerís name
    header_printed BOOLEAN := FALSE;  -- Flag to print the header only once

BEGIN
    -- Fetch the customerís name
    SELECT c.traveler_name
    INTO customer_name
    FROM Customers c
    WHERE c.traveler_id = traveler_id_in;

    -- Count the number of trails the traveler has participated in
    SELECT COUNT(*)
    INTO trail_count
    FROM (
        SELECT bot.traveler_id
        FROM Bikers_on_trail bot
        WHERE bot.traveler_id = traveler_id_in
        UNION ALL
        SELECT hot.traveler_id
        FROM Hikers_on_trail hot
        WHERE hot.traveler_id = traveler_id_in
    );

    IF trail_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Customer with traveler_id ' || traveler_id_in || ' hasn''t gone on any trails.');
        RETURN;
    END IF;

    -- If there are trails, calculate total payment
    OPEN trail_prices;
    LOOP
        FETCH trail_prices INTO trail_rec;
        EXIT WHEN trail_prices%NOTFOUND;

        -- Print the payment summary header only once
        IF NOT header_printed THEN
            DBMS_OUTPUT.PUT_LINE('Payment Summary for ' || customer_name );
            DBMS_OUTPUT.PUT_LINE(' ');
            header_printed := TRUE;
        END IF;

        -- Calculate and print each trail's payment
        DBMS_OUTPUT.PUT_LINE('Trail price: ' || trail_rec.price || ', Number of travelers: ' || trail_rec.number_of_travelers || ', Payment for this trail: ' || (trail_rec.price * trail_rec.number_of_travelers) || ' shekel');
        total_payment := total_payment + (trail_rec.price * trail_rec.number_of_travelers);
    END LOOP;
    CLOSE trail_prices;
    
    -- Print the total payment
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Total payment is ' || total_payment || ' shekel');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for traveler_id ' || traveler_id_in);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'An error occurred: ' || SQLERRM);
END;
/
