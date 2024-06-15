select * from Customers_payment;
select * from Payment;

DELETE FROM customers_payment cp
       WHERE cp.payment_id IN (
             SELECT p.payment_id
             FROM payment p
             WHERE EXTRACT(YEAR FROM p.payment_date) != EXTRACT(YEAR FROM SYSDATE));
             
        
--DeletePayment that wasnt in this past year
DELETE FROM payment p
WHERE EXTRACT(YEAR FROM p.payment_date) != EXTRACT(YEAR FROM SYSDATE);




select * from Employee_at_trail;
select * from Employees;
commit;

DELETE FROM employee_at_trail t
WHERE t.employee_id IN (
    SELECT e.employee_id
    FROM employees e
    WHERE e.age > 65
    AND (
        SELECT COUNT(*)
        FROM employee_at_trail t2
        WHERE t2.employee_id = e.employee_id
    ) < 5
);

DELETE FROM employees e
WHERE age > 65
AND (
    SELECT COUNT(*)
    FROM employee_at_trail t
    WHERE t.employee_id = e.employee_id
) <5;
rollback;
