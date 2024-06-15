--calculating the amount of money evrery trail made
SELECT trail_name, 
       COALESCE(
           (SELECT SUM(P.amount)
            FROM Bikers_on_trail B
            JOIN Customers_payment CP ON B.traveler_id = CP.traveler_id
            JOIN Payment P ON CP.payment_id = P.payment_id
            WHERE B.trail_id = T.trail_id), 0)
       +
       COALESCE(
           (SELECT SUM(P.amount)
            FROM Hikers_on_trail H
            JOIN Customers_payment CP ON H.traveler_id = CP.traveler_id
            JOIN Payment P ON CP.payment_id = P.payment_id
            WHERE H.trail_id = T.trail_id), 0)
       AS total_amount
FROM Trails T
WHERE (SELECT COUNT(*)
       FROM Bikers_on_trail B
       JOIN Customers_payment CP ON B.traveler_id = CP.traveler_id
       JOIN Payment P ON CP.payment_id = P.payment_id
       WHERE B.trail_id = T.trail_id) > 0
   OR
      (SELECT COUNT(*)
       FROM Hikers_on_trail H
       JOIN Customers_payment CP ON H.traveler_id = CP.traveler_id
       JOIN Payment P ON CP.payment_id = P.payment_id
       WHERE H.trail_id = T.trail_id) > 0
ORDER BY trail_name ASC;
