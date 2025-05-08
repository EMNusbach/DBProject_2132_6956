-- Add to TRAILS 
alter table TRAILS modify trail_rating NUMBER NOT NULL;

-- Add to BIKERS_ON_TRAIL 
alter table BIKERS_ON_TRAIL modify rating NUMBER(1) NOT NULL;
 
-- Add to HIKERS_ON_TRAIL 
alter table HIKERS_ON_TRAIL modify rating NUMBER(1) NOT NULL;


-- Add to Employee_at_trail
alter table Employee_at_trail modify work_date DATE NOT NULL;
alter table Employee_at_trail modify job VARCHAR(15) NOT NULL;
