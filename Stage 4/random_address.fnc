-- Create a function to generate addressesd
CREATE OR REPLACE FUNCTION random_address RETURN VARCHAR2 IS
  addresses VARCHAR2(255);
  result    VARCHAR2(255);
BEGIN
  addresses := '12 Herzl Tel Aviv, 34 Dizengoff Tel Aviv, 56 Ben Yehuda Tel Aviv, 78 Allenby Tel Aviv, 90 Rothschild Tel Aviv, 8 Herzl Jerusalem, 34 Rakefet Netanya, 16 Ben Yehuda Tel Aviv, 8 Allenby Jerusalem';
  -- Generate a random integer index between 1 and 9
  SELECT REGEXP_SUBSTR(addresses, '[^,]+', 1, TRUNC(dbms_random.value(1, 10))) INTO result FROM dual;
  RETURN result;
END;
/
