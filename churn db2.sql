USE ecomm;

select * from customer_churn;

SET SQL_SAFE_UPDATES = 0;

-- 2. Data Transformation:

-- a) Column Renaming
ALTER TABLE customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;

ALTER TABLE customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;

-- b) Creating New Columns
ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(3);

UPDATE customer_churn
SET ComplaintReceived = IF(Complain = 1, 'Yes', 'No');

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);

UPDATE customer_churn
SET ChurnStatus = IF(Churn = 1, 'Churned', 'Active');

-- c) Column Dropping
ALTER TABLE customer_churn DROP COLUMN Complain;
ALTER TABLE customer_churn DROP COLUMN Churn;


-- Priscilla Philby Oommen (DA02)