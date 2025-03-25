-- HR Analytics SQL Script --
DROP TABLE IF EXISTS hr_attrition;

CREATE TABLE hr_attrition (
    age INT,
    attrition VARCHAR(3),  -- 'Yes' or 'No'
    business_travel VARCHAR(50),
    daily_rate INT,
    department VARCHAR(50),
    distance_from_home INT,
    education INT,
    education_field VARCHAR(50),
    employee_count INT,
    employee_number INT PRIMARY KEY,  -- Unique identifier
    environment_satisfaction INT,
    gender VARCHAR(10),
    hourly_rate INT,
    job_involvement INT,
    job_level INT,
    job_role VARCHAR(50),
    job_satisfaction INT,
    marital_status VARCHAR(20),
    monthly_income INT,
    monthly_rate INT,
    num_companies_worked INT,
    overtime VARCHAR(3),  -- 'Yes' or 'No'
    percent_salary_hike INT,
    performance_rating INT,
    relationship_satisfaction INT,
    standard_hours INT,
    stock_option_level INT,
    total_working_years INT,
    training_times_last_year INT,
    work_life_balance INT,
    yrs_at_company INT,
    yrs_in_current_role INT,
    yrs_since_last_promotion INT,
    yrs_with_curr_manager INT
);

--import csv data...
Drop Table If Exists hr_attrition_transformed;
CREATE TABLE hr_attrition_transformed AS  --the new table for analysis in R and EDA.
Select *
From hr_attrition;

-- Basic EDA in SQL to answer a few questions and prep data for R --

--------------------------------
-- Check Data for Consistency --
--------------------------------
Select Distinct(business_travel)
From hr_attrition_transformed; --3 levels. No typos.

Select Distinct(gender)
From hr_attrition_transformed; -- No typos

Select Distinct(department)
From hr_attrition_transformed; --No typos

Select Distinct(job_role)
From hr_attrition_transformed; --No typos

Select Distinct(education_field)
From hr_attrition_transformed; --No typos

--------------------------------------------------------------------
-- Identify Count of Null Values in Attrition and Employee Number --
--------------------------------------------------------------------
Select *
From hr_attrition_transformed
Where attrition is NULL OR employee_number is NULL;

------------------------------
-- Drop unnecessary columns --
------------------------------
-- these columns have no meaning whatsoever and do not contribute to this project.

Alter Table hr_attrition_transformed
Drop Column daily_rate,
Drop Column hourly_rate,
Drop Column monthly_rate,
Drop Column distance_from_home,
Drop Column standard_hours,
Drop Column employee_count;

Select *
From hr_attrition_transformed;

-----------------------------
-- Calculate Annual Income --
-----------------------------
Alter Table hr_attrition_transformed
Add Column annual_income INT;

Update hr_attrition_transformed
Set annual_income = (monthly_income * 12)/1000; --for scaling

Select annual_income
From hr_attrition_transformed;

--------------------------------------
-- Count of Yes/No for  'attrition' --
--------------------------------------
Select attrition,
COUNT(*) AS count_attrition
From hr_attrition_transformed
Group By attrition
Order By attrition;
-- NOTE: this is an imbalanced data set. Important for our model.

---------------------------------------
-- Count of other relevant variables --
---------------------------------------

-- Business travel
Select business_travel, attrition,
	Count(business_travel) AS count_bus_travel,
		ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By business_travel),2) AS rate
From hr_attrition_transformed
Group By business_travel, attrition
Order By business_travel, attrition;
	--NOTE: Those who travel at all have a higher rate of leaving. 
	-- Dont quite know how much this plays a role in leaving, however.


-- Department
Select department, attrition,
	Count(department) AS count_department,
		ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By department),2) AS rate
From hr_attrition_transformed
Group By department, attrition
Order By department, attrition;
	--NOTE: In terms of total employees, sales has a large rate of attrition.
	-- Also, see jobrole:sales representatives below. Also a high rate.


-- Overtime (1= Yes, 0 = No)
Select overtime, attrition,
	Count(overtime) AS count_overtime,
	ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By overtime),2) AS rate
From hr_attrition_transformed
Group By overtime, attrition
Order By overtime, attrition;
	--NOTE: Working overtime looks like a big reason to why employees leave.
	-- I would be curious to see how overtime is handled in these work places
	-- (unpaid, low pay, bad conditions, etc..)


-- Gender (1 = Male, 0 = Female)
Select gender, attrition,
	Count(gender) AS count_gender,
	ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By gender),2) AS rate
From hr_attrition_transformed
Group By gender, attrition
Order By gender, attrition;
	--NOTE: men and women share about the same rate. No glaring differences.


-- Job Role
Select job_role, attrition,
	Count(job_role) AS count_jobrole,
	ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By job_role),2) AS rate
From hr_attrition_transformed
Group By job_role, attrition
Order By job_role, attrition;
	--NOTE: Not too sure why Sales Representatives have a high rate of attrition.
	--Would need to look more into how that job role plays out in careers.


-- Education Field
Select education_field, attrition,
	Count(education_field) AS count_edufield,
	ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By education_field),2) AS rate
From hr_attrition_transformed
Group By education_field, attrition
Order By education_field, attrition;
	--NOTE: Those with technical degrees have the largest rate with more
	-- than 100 people. Perhaps finding better jobs, higher pay for their
	-- skills, etc...


-- Marital Status
Select marital_status, attrition,
	Count(marital_status) AS count_marital_status,
	ROUND((Count(*) * 100.0) / Sum(Count(*)) OVER (Partition By marital_status),2) AS rate
From hr_attrition_transformed
Group By marital_status, attrition
Order By marital_status, attrition;
	--NOTE: single people are leaving at a higher rate, which could
	-- be interpreted as maybe not having an established career or 
	-- the flexibility to look for other jobs without bigger consequences.

----------------------------------------
-- Range and Average of annual income --
----------------------------------------
Select attrition, 
		MIN(annual_income) AS min_income, 
		MAX(annual_income) AS max_income,
		ROUND(AVG(annual_income), 2) AS avg_income 
From hr_attrition_transformed
Group By attrition
Order By attrition; 
	--NOTE: those leaving earn about 25K less. Range looks similar, 
	-- but distribution might be different. We can easier see the median in R.