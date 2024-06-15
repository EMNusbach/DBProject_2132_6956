--params query customers birthday
SELECT 
    customer.traveler_id,
    customer.traveler_name,
    customer.traveler_age,
    customer.contact_info,
    customer.trip_date,
    TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(customer.trip_date, 'YYYY') AS trip_years_ago,
    customer.birth_date
FROM 
    Customers customer
WHERE 
    TO_CHAR(&<name="Enter Date" type="date" default=sysdate>, 'DD-MM') = TO_CHAR(customer.birth_date, 'DD-MM')
ORDER BY 
    customer.birth_date;
    
--params query trails by level and price
SELECT
    t.trail_name,
    t.location,
    t.price
FROM
    Trails t
WHERE
    t.difficulty_level = &<name="difficulty level" list="Easy, Moderate, Difficult"
    type="string">
    and t.price between &<name="minimum price" type=integer>
 and &<name="maximum price" type=integer>
ORDER BY  t.price;


--biking trails by terrain and trail length
   
SELECT
    t.trail_name,
    t.location,
    b.length,
    b.terrain_description,
    t.price
FROM
    Biking_Trails b
JOIN
    Trails t ON b.trail_id = t.trail_id
WHERE
    b.terrain_description = &<name="terrain description" list="flat, hilly, smooth, rocky" type="string">
    AND b.length BETWEEN &<name="minimum length" type="integer"> AND &<name="maximum length" type="integer">
ORDER BY
    b.length;

-- all payments made from min price between dates
SELECT
    cp.payment_id,
    c.traveler_name,
    c.contact_info,
    p.amount,
    p.payment_date
FROM
    Customers_payment cp
JOIN
    Payment p ON cp.payment_id = p.payment_id
JOIN
    Customers c ON cp.traveler_id = c.traveler_id
WHERE
    p.amount >= &<name="min_amount" type="integer">
    AND p.payment_date BETWEEN TO_DATE(&<name="start_date"  type=string
 default="01/01/2024"> ,'DD/MM/YYYY')
                            AND TO_DATE(&<name="end_date"  type=string
 default="1/06/2024"> ,'DD/MM/YYYY')
ORDER BY
    p.payment_date DESC;
