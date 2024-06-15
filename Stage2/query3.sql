--Average price of trails by location
SELECT 
    location,
    CEIL(AVG(price)) AS average_price
FROM (
    SELECT 
        T.location,
        T.price
    FROM 
        Trails T
    WHERE EXISTS (
        SELECT 1 
        FROM Biking_Trails BT 
        WHERE BT.trail_id = T.trail_id
    )
    UNION ALL
    SELECT 
        T.location,
        T.price
    FROM 
        Trails T
    WHERE EXISTS (
        SELECT 1 
        FROM Hiking_Trails HT 
        WHERE HT.trail_id = T.trail_id
    )
) TrailPricesByLocation
GROUP BY 
    location
ORDER BY 
    location ASC, average_price DESC;
