-- Step 1: Find the unique constraint name
SELECT constraint_name
FROM user_cons_columns
WHERE table_name = 'PERSON' AND column_name = 'EMAIL';

-- Step 2: Drop the unique constraint (replace EMAIL_UNIQUE with the actual constraint name found)
ALTER TABLE person DROP CONSTRAINT SYS_C008392;
