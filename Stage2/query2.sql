-- Calculate the total number of hikers and bikers for each trail over the past 12 months
-- and then find the trail with the maximum combined total of hikers and bikers
SELECT 
    trail_name,
    MAX(total_hikers + total_bikers) AS total_hikers_and_bikers
FROM (
    SELECT 
        T.trail_name,
        (
            SELECT COUNT(DISTINCT HOT.traveler_id)
            FROM Hikers_on_trail HOT
            JOIN Hiking_Trails HT ON HOT.trail_id = HT.trail_id
            JOIN Customers C ON HOT.traveler_id = C.traveler_id
            WHERE HT.trail_id = T.trail_id
            AND C.trip_date >= ADD_MONTHS(SYSDATE, -12)
        ) AS total_hikers,
        (
            SELECT COUNT(DISTINCT BOT.traveler_id)
            FROM Bikers_on_trail BOT
            JOIN Biking_Trails BT ON BOT.trail_id = BT.trail_id
            JOIN Customers C ON BOT.traveler_id = C.traveler_id
            WHERE BT.trail_id = T.trail_id
            AND C.trip_date >= ADD_MONTHS(SYSDATE, -12)
        ) AS total_bikers
    FROM 
        Trails T
) subquery
GROUP BY 
    trail_name
ORDER BY 
    total_hikers_and_bikers DESC;
