USE ecomm;

select * from customer_churn;

SET SQL_SAFE_UPDATES = 0;

-- 1. Data Cleaning

-- a) Handling Missing Values and Outliers

-- Check for NULL values
SELECT COUNT(*) AS NullCount
FROM customer_churn
WHERE WarehouseToHome IS NULL;

SELECT COUNT(*) AS NullCount
FROM customer_churn
WHERE HourSpendOnApp IS NULL;

SELECT COUNT(*) AS NullCount
FROM customer_churn
WHERE OrderAmountHikeFromlastYear IS NULL;

SELECT COUNT(*) AS NullCount
FROM customer_churn
WHERE DaySinceLastOrder IS NULL;

-- Replace NULL values with Mean
UPDATE customer_churn
SET WarehouseToHome = (SELECT ROUND(AVG(WarehouseToHome)) 
FROM (SELECT WarehouseToHome FROM customer_churn WHERE WarehouseToHome IS NOT NULL) AS col1)
WHERE WarehouseToHome IS NULL;

UPDATE customer_churn
SET HourSpendOnApp = (SELECT ROUND(AVG(HourSpendOnApp)) 
FROM (SELECT HourSpendOnApp FROM customer_churn WHERE HourSpendOnApp IS NOT NULL) AS col2)
WHERE HourSpendOnApp IS NULL;

UPDATE customer_churn
SET OrderAmountHikeFromlastYear = (SELECT ROUND(AVG(OrderAmountHikeFromlastYear)) 
FROM (SELECT OrderAmountHikeFromlastYear FROM customer_churn WHERE OrderAmountHikeFromlastYear IS NOT NULL) AS col3)
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE customer_churn
SET DaySinceLastOrder = (SELECT ROUND(AVG(DaySinceLastOrder)) 
FROM (SELECT DaySinceLastOrder FROM customer_churn WHERE DaySinceLastOrder IS NOT NULL) AS col4)
WHERE DaySinceLastOrder IS NULL;

-- Mode
SELECT Tenure, COUNT(*) AS tenure_count
FROM customer_churn
WHERE Tenure IS NOT NULL
GROUP BY Tenure
ORDER BY tenure_count DESC
LIMIT 1;

UPDATE customer_churn
SET Tenure = 1
WHERE Tenure IS NULL;

SELECT CouponUsed, COUNT(*) AS coupon_count
FROM customer_churn
WHERE CouponUsed IS NOT NULL
GROUP BY CouponUsed
ORDER BY coupon_count DESC
LIMIT 1;

UPDATE customer_churn
SET CouponUsed = 1
WHERE CouponUsed IS NULL;

SELECT OrderCount, COUNT(*) AS count_orders
FROM customer_churn
WHERE OrderCount IS NOT NULL
GROUP BY OrderCount
ORDER BY count_orders DESC
LIMIT 1;

-- mode of OrderCount is 2

UPDATE customer_churn
SET OrderCount = 2
WHERE OrderCount IS NULL;

-- Handling outliers
SELECT *
FROM customer_churn
WHERE WarehouseToHome > 100;  -- 2 records found

DELETE FROM customer_churn
WHERE WarehouseToHome > 100;

-- b) Dealing with Inconsistencies
-- Replace "Phone" with "Mobile Phone" in PreferredLoginDevice
UPDATE customer_churn
SET PreferredLoginDevice = REPLACE(PreferredLoginDevice, 'Phone', 'Mobile Phone')
WHERE PreferredLoginDevice = 'Phone';

-- Replace "Mobile" with "Mobile Phone" in PreferedOrderCat
UPDATE customer_churn
SET PreferedOrderCat = REPLACE(PreferedOrderCat, 'Mobile', 'Mobile Phone')
WHERE PreferedOrderCat = 'Mobile';

-- Replace "COD" with "Cash on Delivery"
UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

-- Replace "CC" with "Credit Card"
UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';


-- Priscilla Philby Oommen (DA02)