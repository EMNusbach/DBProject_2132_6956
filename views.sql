-- Our data base views 
CREATE VIEW Original_Department_Trail_View AS
SELECT 
    e.employee_name,
    e.employee_id,
    e.seniority,
    e.contact_info,
    et.work_date,
    et.job,
    t.trail_name,
    t.difficulty_level,
    t.location,
    t.price,
    t.trail_rating
FROM 
    Employees e
JOIN 
    Employee_at_trail et ON e.employee_id = et.employee_id
JOIN 
    Trails t ON et.trail_id = t.trail_id;



--Employees Working on Trails with High Ratings
SELECT 
    employee_name, 
    trail_name, 
    trail_rating 
FROM 
    Original_Department_Trail_View 
WHERE 
    trail_rating >3;



--Count of Employees by Job Role

SELECT 
    job, 
    COUNT(employee_id) AS employee_count 
FROM 
    Original_Department_Trail_View 
GROUP BY 
    job;


-- Given DataBase views 
CREATE VIEW Received_Department_Donation_View AS
SELECT 
    d.personid,
    c.campaignname,
    c.donationgoal,
    SUM(do.amount) AS total_donated
FROM 
    Donor d
JOIN 
    Donation do ON d.personid = do.donorid
JOIN 
    Campaign c ON do.campaignid = c.campaignid
GROUP BY 
    d.personid, c.campaignname, c.donationgoal;

-- Total Donations per Campaign
SELECT 
    campaignname AS campaign_name,  -- Adjusted to match view
    total_donated 
FROM 
    Received_Department_Donation_View 
WHERE 
    total_donated > 1000;  

-- Donors by Contribution Amount
SELECT 
    p.FIRSTNAME || ' ' || p.LASTNAME AS donor_name,  -- Concatenate first and last name
    rdd.total_donated 
FROM 
    Received_Department_Donation_View rdd
JOIN 
    Person p ON rdd.personid = p.PERSONID  -- Join on personid
ORDER BY 
    rdd.total_donated DESC;

    
drop view Received_Department_Donation_View;
