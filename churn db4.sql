-- To identify patterns related to customer churn and gain actionable business insights

USE ecomm;

select * from customer_churn;

-- 1. Churn Rate Overview
SELECT ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY ChurnStatus;
--  Insight: Understand the proportion of customers who have churned vs those who are active.
-- churned customers: 948, active customers: 4680

-- 2. Churn by City Tier
SELECT CityTier, COUNT(*) AS ChurnedCustomers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY CityTier
ORDER BY ChurnedCustomers DESC;
-- Insight: Helps prioritize retention strategies in city tiers with high churn.
-- CityTier 1: 532 , CityTier 3: 368 , CityTier 2: 48

-- 3. Average Tenure of Churned vs Active Customers
SELECT ChurnStatus, ROUND(AVG(Tenure)) AS AvgTenure
FROM customer_churn
GROUP BY ChurnStatus;
-- Insight: Reveals if churn is more common among newer or longer-tenure customers.
-- Churned: 3 months , Active: 11 months

-- 4. Top Reasons for Churn (Complaints)
SELECT ComplaintReceived, COUNT(*) AS ChurnedCount
FROM customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY ComplaintReceived;
-- Insight: Correlation between complaints and churn.
-- Yes: 508, No: 440

-- 5. Churn by Preferred Payment Mode
SELECT PreferredPaymentMode, COUNT(*) AS ChurnedCustomers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY PreferredPaymentMode
ORDER BY ChurnedCustomers DESC;
-- Insight: Evaluate whether payment convenience influences churn.
-- Debit Card: 356, Credit Card: 252, E wallet: 140, Cash on Delivery:128, UPI: 72

-- 6. Devices and App Usage among Churned Users
SELECT ROUND(AVG(NumberOfDeviceRegistered)) AS AvgDevices, ROUND(AVG(HoursSpentOnApp)) AS AvgAppHours
FROM customer_churn
WHERE ChurnStatus = 'Churned';
-- Insight: Determine digital engagement of churned users.
--  Average number of Devices registered: 4 devices, Average number of hours spent on app (app usage): 3 hours

-- 7. Cashback & Order Hike vs Churn
SELECT ROUND(AVG(CashbackAmount)) AS AvgCashback, ROUND(AVG(OrderAmountHikeFromlastYear)) AS AvgOrderHike
FROM customer_churn
WHERE ChurnStatus = 'Churned';
-- Insight: Analyze if incentives like cashback affect churn.
-- Average Cashback Amount: 160, Average Order Hike: 16

-- 8. Churn by Preferred Order Category
SELECT PreferredOrderCat, COUNT(*) AS ChurnedCustomers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY PreferredOrderCat
ORDER BY ChurnedCustomers DESC;
-- Insight: Identify which product categories see higher churn.
-- Mobile Phone: 570, Laptop & Accessory: 210, Fashion: 128, Others: 20, Grocery: 20

-- 9. Complaint Rate among Churned Customers
SELECT ROUND(100.0 * SUM(CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS ComplaintRatePercent
FROM customer_churn
WHERE ChurnStatus = 'Churned';
-- Insight: Quantifies how complaints drive churn — useful for service improvement.
-- Complaint Rate Percentage: 53.59 %

-- Patterns extracted:
-- a) Short-tenure users churn more
-- b) Certain city tiers or product categories show high churn
-- c) Complaints are a major churn driver

-- Recommendations:
-- Make targeted interventions like
-- a) Onboarding support for new users
-- b) Loyalty programs for high-risk categories
-- c) Faster issue resolution for complaining users