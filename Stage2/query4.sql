-- Total number of travelers on hiking and biking trails by date
SELECT 
    T.trail_name,
    C.trip_date,
    SUM(C.number_of_travelers) AS total_travelers
FROM 
    Trails T
JOIN
    (
        SELECT 
            B.trail_id,
            B.traveler_id
        FROM 
            Bikers_on_trail B
        UNION ALL
        SELECT 
            H.trail_id,
            H.traveler_id
        FROM 
            Hikers_on_trail H
    ) All_Trails ON T.trail_id = All_Trails.trail_id
JOIN 
    Customers C ON All_Trails.traveler_id = C.traveler_id
GROUP BY 
    T.trail_name,
    C.trip_date
ORDER BY 
    C.trip_date DESC,
    total_travelers DESC;
