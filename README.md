## **Project Title**
E-Commerce Customer Churn Analysis using MySQL 

## **Problem Statement**

In the realm of e-commerce, businesses face the challenge of understanding customer churn patterns to ensure customer satisfaction and sustained profitability. This project aims to delve into the dynamics of customer churn within an e-commerce domain, utilizing historical transactional data to uncover underlying patterns and drivers of churn. By analyzing customer attributes such as tenure, preferred payment modes, satisfaction scores, and purchase behavior, the project seeks to investigate and understand the dynamics of customer attrition and their propensity to churn. The ultimate objective is to equip e-commerce enterprises with actionable insights to implement targeted retention strategies and mitigate churn, thereby fostering long-term customer relationships and ensuring business viability in a competitive landscape. 


## 📌 **Project Objectives**

The main goal of this project is to analyze customer behavior and identify patterns that lead to churn in an e-commerce business. This will help stakeholders make **data-driven decisions** to improve customer retention and enhance user experience.

**Specific Objectives:**

1. **Clean and prepare** the customer dataset for analysis.
2. **Identify churn drivers** by analyzing behavioral and transactional features.
3. Perform **descriptive and diagnostic analysis** to uncover key insights.
4. **Segment customers** based on tenure, complaint status, satisfaction, etc.
5. Provide **actionable business insights** through SQL-based analytics.


## 🔍 **Project Steps**

### 1. **Data Cleaning and Preparation**

* Handle missing values using mean/mode imputation.
* Round off numerical columns where appropriate.
* Replace inconsistent categorical entries (e.g., "Phone" to "Mobile Phone").
* Remove outliers (e.g., extreme WarehouseToHome distances).

### 2. **Feature Engineering**

* Create new columns like:

  * `ChurnStatus` ("Churned" or "Active")
  * `ComplaintReceived` ("Yes" or "No")
  * `DistanceCategory` based on WarehouseToHome value.

### 3. **Exploratory Data Analysis (EDA) using SQL**

**Key Questions Answered:**

* What is the **count** of churned vs. active customers?
* What is the **average tenure** and **cashback amount** for churned users?
* Which **preferred order categories** are common among churned customers?
* Which **city tier** has the highest number of churned customers?
* What are the **preferred payment modes** of high-value or loyal customers?
* Which **gender** uses the most coupons?
* Are **complaints linked to churn**?

### 4. **Segmentation and Group Analysis**

* Identify segments based on:

  * Tenure
  * Payment method
  * Complaint status
  * Device usage
* Analyze churn within each segment.

### 5. **Insights & Recommendations**

**Insights**

* Short-tenure users churn more

* Certain city tiers or product categories show high churn

* Complaints are a major churn driver


**Recommendations**

* Onboarding support for new users

* Loyalty programs for high-risk categories

* Faster issue resolution for complaining users
