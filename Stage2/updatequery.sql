--update customers age by thier birth date
select * from customers

UPDATE customers c
SET c.traveler_age = EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM c.birth_date)
                     - CASE
                         WHEN EXTRACT(MONTH FROM SYSDATE) < EXTRACT(MONTH FROM c.birth_date) THEN 1
                         WHEN EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM c.birth_date)
                         AND EXTRACT(DAY FROM SYSDATE) < EXTRACT(DAY FROM c.birth_date) THEN 1
                         ELSE 0
                           END;
           
   
--update trails to be closed by 3 varibles
select * from Trails        
           
UPDATE trails t
SET t.open_closed = 'closed'
WHERE t.location = 'Upper Galilee'
      OR t.trail_id IN (
          SELECT ht.trail_id 
          FROM Hiking_Trails ht 
          WHERE ht.duration > 10
      )
      OR t.trail_id IN (
          SELECT bt.trail_id 
          FROM Biking_Trails bt 
          WHERE bt.length > 8
);


