-- insert donation data into payment
BEGIN
  FOR rec IN (SELECT donationid, numofpayments, amount, donationdate, paymentmethod FROM donation) LOOP
    BEGIN
      -- Insert data into payment table, using donationid as payment_id
      INSERT INTO payment (payment_id, number_of_payments, amount, payment_date, payment_method)
      VALUES (rec.donationid, rec.numofpayments, rec.amount, rec.donationdate, rec.paymentmethod);
    END;
  END LOOP;
END;

-- changing the column name from donorid to person_id
ALTER TABLE donation RENAME COLUMN donorid TO person_id;
ALTER TABLE donation RENAME COLUMN donationid TO payment_id;

--droping the overlapping columns from the donation table
ALTER TABLE donation DROP COLUMN numofpayments;
ALTER TABLE donation DROP COLUMN amount;
ALTER TABLE donation DROP COLUMN donationdate;
ALTER TABLE donation DROP COLUMN paymentmethod;

--adding a foreign key
ALTER TABLE donation
ADD CONSTRAINT fk_payment_id
FOREIGN KEY (payment_id)
REFERENCES payment(payment_id);



commit;


