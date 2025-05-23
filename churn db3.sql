USE ecomm;

select * from customer_churn;

SET SQL_SAFE_UPDATES = 0;

-- 3. Data Exploration and Analysis

-- 3.1) Retrieve the count of churned and active customers
SELECT ChurnStatus, COUNT(*) AS TotalCustomers
FROM customer_churn
GROUP BY ChurnStatus;
-- churned customers: 948, active customers: 4680

-- 3.2) Display the average tenure and total cashback amount of customers who churned
SELECT Round(AVG(Tenure)) AS AverageTenure, SUM(CashbackAmount) AS TotalCashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';
-- average tenure: 3, total cashback amount: 1,52,030 for churned customers

-- 3.3) Determine the percentage of churned customers who complained
SELECT
  ROUND(
    100 * SUM(CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2
  ) AS PercentageChurnedWhoComplained
FROM customer_churn
WHERE ChurnStatus = 'Churned';
-- percentage of churned customers who complained: 53.59 %

-- 3.4) Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory
SELECT ChurnStatus, PreferredOrderCat, CityTier, COUNT(*) AS CountChurnedCustomers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY CountChurnedCustomers DESC
LIMIT 1;
-- city tier: 3, number of churned customers: 150

-- 3.5) Identify the most preferred payment mode among active customers
SELECT ChurnStatus, PreferredPaymentMode, COUNT(*) AS CountActiveCustomers
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY CountActiveCustomers DESC
LIMIT 1;
-- most preferred payment mode: Debit Card, number of active customers: 1956

-- 3.6) Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering
SELECT MaritalStatus, PreferredOrderCat, SUM(OrderAmountHikeFromlastYear) AS TotalOrderAmountHike
FROM customer_churn
WHERE MaritalStatus = 'Single' AND PreferredOrderCat = 'Mobile Phone';
-- total order amount hike from last year: 12,177

-- 3.7) Find the average number of devices registered among customers who used UPI as their preferred payment mode
SELECT PreferredPaymentMode, ROUND(AVG(NumberOfDeviceRegistered)) AS AverageNoDevicesRegistered
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';
-- average number of devices registered: 4

-- 3.8) Determine the city tier with the highest number of customers
SELECT CityTier, COUNT(CustomerID) AS CountNoCustomers
FROM customer_churn
GROUP BY CityTier
ORDER BY CountNoCustomers DESC
LIMIT 1;
-- city tier: 1 , number of customers: 3,666

-- 3.9) Identify the gender that utilized the highest number of coupons
select Gender, sum(CouponUsed) as TotalCouponsUsed
from customer_churn
group by Gender
order by TotalCouponsUsed desc
limit 1;
-- gender: Male, number of coupons used: 5,629

-- 3.10) List the number of customers and the maximum hours spent on the app in each preferred order category
select PreferredOrderCat, count(CustomerID) as CountNoCustomers, max(HoursSpentOnApp) as MaxHoursSpentOnApp
from customer_churn
group by PreferredOrderCat;

-- 3.11) Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score
SELECT PreferredPaymentMode, MAX(SatisfactionScore), SUM(OrderCount) AS TotalOrderCount
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card' AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn WHERE PreferredPaymentMode = 'Credit Card');
-- total order count: 1,122 , maximum satisfaction score: 5

-- 3.12) What is the average satisfaction score of customers who have complained? 
SELECT ComplaintReceived, ROUND(AVG(SatisfactionScore)) AS AvgSatScore
FROM customer_churn
WHERE ComplaintReceived = 'Yes';
-- average satisfaction score: 3

-- 3.13) List the preferred order category among customers who used more than 5 coupons
SELECT PreferredOrderCat, CouponUsed
FROM customer_churn
WHERE CouponUsed > 5;

-- 3.14) List the top 3 preferred order categories with the highest average cashback amount.
SELECT PreferredOrderCat, ROUND(AVG(CashbackAmount)) AS AvgCashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY AvgCashback DESC
LIMIT 3;

-- 3.15) Find the preferred payment modes of customers whose average tenure is 10 months and have placed more than 500 orders.
SELECT PreferredPaymentMode, ROUND(AVG(Tenure)), SUM(OrderCount)
FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING ROUND(AVG(Tenure)) = 10 AND SUM(OrderCount) > 500;
-- preferred payment modes: Debit Card, Credit Card, E Wallet

-- 3.16) Categorize customers based on their distance from the warehouse to home such as 'Very Close Distance' for distances <=5km, 'Close Distance' for <=10km, 'Moderate Distance' for <=15km, and 'Far Distance' for >15km. Then, display the churn status breakdown for each distance category. 
SELECT 
  CASE 
    WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
    WHEN WarehouseToHome <= 10 THEN 'Close Distance'
    WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
    ELSE 'Far Distance'
  END AS DistanceCategory,
ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus
ORDER BY CustomerCount DESC;

-- 3.17) List the customer’s order details who are married, live in City Tier-1, and their order counts are more than the average number of orders placed by all customers.
SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married' AND CityTier = 1 AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);

-- 3.18) a: Create a ‘customer_returns’ table in the ‘ecomm’ database and insert the following data. 
CREATE TABLE customer_returns (
  ReturnID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT NOT NULL,
  ReturnDate DATE,
  RefundAmount INT);

INSERT INTO customer_returns (CustomerID, ReturnDate, RefundAmount)
VALUES 
  (50022, '2023-01-01', 2130),
  (50316, '2023-01-23', 2000),
  (51099, '2023-02-14', 2290),
  (52321, '2023-03-08', 2510),
  (52928, '2023-03-20', 3000),
  (53749, '2023-04-17', 1740),
  (54206, '2023-04-21', 3250),
  (54838 , '2023-04-30', 1990);

-- 3.18) b: Display the return details along with the customer details of those who have churned and have made complaints.
SELECT 
  cr.*,
  cc.*
FROM customer_returns AS cr
INNER JOIN customer_churn AS cc 
ON cr.CustomerID = cc.CustomerID
WHERE cc.ChurnStatus = 'Churned' AND cc.ComplaintReceived = 'Yes';


-- Priscilla Philby Oommen (DA02)