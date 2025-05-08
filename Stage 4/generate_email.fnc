-- Create a function to generate email addresses
CREATE OR REPLACE FUNCTION generate_email (first_name VARCHAR2, last_name VARCHAR2) RETURN VARCHAR2 IS

BEGIN
  RETURN LOWER(first_name || last_name || '@gmail.com');
END;
/
