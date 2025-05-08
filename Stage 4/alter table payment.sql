-- Alter table payment

--adding 2 columns to the payment table
ALTER TABLE payment
ADD (number_of_payments NUMBER(3),
     payment_method VARCHAR2(20));


--generting random data
BEGIN
  FOR rec IN (SELECT ROWID, number_of_payments, payment_method FROM payment) LOOP
    DECLARE
      random_payments NUMBER(3);
      random_method VARCHAR2(20);
    BEGIN
      -- Generate random number of payments between 1 and 10
      random_payments := ROUND(DBMS_RANDOM.VALUE(1, 10));

      -- Generate random payment method
      random_method := CASE ROUND(DBMS_RANDOM.VALUE(1, 4))
                         WHEN 1 THEN 'Credit Card'
                         WHEN 2 THEN 'Debit Card'
                         WHEN 3 THEN 'PayPal'
                         WHEN 4 THEN 'Bank Transfer'
                       END;

      -- Update the payment table with random values
      UPDATE payment
      SET number_of_payments = random_payments,
          payment_method = random_method
      WHERE ROWID = rec.ROWID;
    END;
  END LOOP;
END;

commit;

