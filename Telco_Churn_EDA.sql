-- View the table columns
SELECT TOP (100) *
FROM kaggle.TelcoChurn

-- Number of distinct Customers
SELECT COUNT (DISTINCT customerID) AS TotalCustomers
FROM kaggle.TelcoChurn

-- Distinct Churn categories
SELECT DISTINCT Churn AS ChurnCat
FROM kaggle.TelcoChurn

-- Retained Vs Churned Customers (in the last month)
SELECT 
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (*) AS TotalNumber
FROM kaggle.TelcoChurn
GROUP BY Churn

-- CTE to calculate the percentage of each churn category
WITH CustomerStatus (Status, TotalNumber)
AS
(
	SELECT 
		CASE	
			WHEN Churn = 'Yes' THEN 'Churned'
			ELSE 'Retained'
			END AS Status,
		COUNT (*) AS TotalNumber
	FROM kaggle.TelcoChurn
	GROUP BY Churn
)
SELECT Status, TotalNumber, TotalNumber *100/ SUM(TotalNumber) OVER () AS Percentage 
FROM CustomerStatus

-- Churn by gender type
SELECT gender,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (Churn) AS NoOfCustomers
FROM kaggle.TelcoChurn
GROUP BY gender, Churn
ORDER BY 2

--Churn by Senior Citizen
SELECT 
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
		COUNT (SeniorCitizen) AS SeniorCitizen
FROM kaggle.TelcoChurn
GROUP BY SeniorCitizen, Churn
HAVING SeniorCitizen = 1
-- The churn is quite high for Senior Citizens, we would delve deeper into likely reasons later

-- Churn by people with partners
SELECT 
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
		COUNT (Partner) AS HasPartner
FROM kaggle.TelcoChurn
GROUP BY Partner, Churn
HAVING Partner = 'Yes'

-- Churn by people with dependents
SELECT 
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
		COUNT (Dependents) AS HasDependents
FROM kaggle.TelcoChurn
GROUP BY Dependents, Churn
HAVING Dependents = 'Yes'

--Distinct tenure type
SELECT Distinct tenure
FROM kaggle.TelcoChurn

--Tenure Vs Churn
SELECT tenure,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status, 
		COUNT (tenure) AS NumberOfCustomers
FROM kaggle.TelcoChurn
GROUP BY tenure, Churn
ORDER BY 1,2
-- The longer the tenure, the less likely it is for a customer to churn

-- CHURN BY SERVICE TYPES
-- Churn by Service type - Phone Service
SELECT 
	Churn,
	COUNT (PhoneService) AS PhoneService
FROM kaggle.TelcoChurn
GROUP BY Churn, PhoneService
HAVING PhoneService = 'Yes'

-- Churn by customers with Multiple Lines
SELECT 
	Churn,
	COUNT (MultipleLines) AS MultipleLines
FROM kaggle.TelcoChurn
GROUP BY Churn, MultipleLines
HAVING MultipleLines = 'Yes'

-- Churn by customers with Internet Service
SELECT 
	InternetService,
	Churn,
	COUNT (InternetService) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, InternetService
HAVING InternetService NOT LIKE 'No'
ORDER BY 1
-- Huge percentage of Fiber Optic customers churned


-- Churn by customers with Online Security
SELECT 
	OnlineSecurity,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status, 
	COUNT (OnlineSecurity) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, OnlineSecurity
HAVING OnlineSecurity NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Online Backup
SELECT 
	OnlineBackup,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (OnlineBackup) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, OnlineBackup
HAVING OnlineBackup NOT LIKE 'No Internet Service'
ORDER BY 1
--Customers with Online backup are less likely to churn

-- Churn by customers with Device Protection
SELECT 
	DeviceProtection,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (DeviceProtection) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, DeviceProtection
HAVING DeviceProtection NOT LIKE 'No Internet Service'
ORDER BY 1
--Customers with Device protection are less likely to churn

-- Churn by customers with Tech Support
SELECT 
	TechSupport,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (TechSupport) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, TechSupport
HAVING TechSupport NOT LIKE 'No Internet Service'
ORDER BY 1
--Customers with Tech Support are less likely to churn

-- Churn by customers with Streaming TV
SELECT 
	StreamingTV,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (StreamingTV) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, StreamingTV
HAVING StreamingTV NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Streaming Movies
SELECT 
	StreamingMovies,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (StreamingMovies) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, StreamingMovies
HAVING StreamingMovies NOT LIKE 'No Internet Service'
ORDER BY 1 


--Churn by Contract Type
SELECT 
	Contract,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (Contract) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, Contract
ORDER BY 1,2
--Longer contract term reduces churn

-- Churn by Billing methods
SELECT 
	PaperlessBilling,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (PaperlessBilling) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, PaperlessBilling
ORDER BY 1,2
-- Many customers with Paperless billing churned

-- Churn by Payment methods
SELECT 
	PaymentMethod,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (PaymentMethod) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, PaymentMethod
ORDER BY 1,2
-- Many customers who pay with electronic check churned. 

-- Churn by Total Charges
SELECT 
	TotalCharges,
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (TotalCharges) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, TotalCharges
ORDER BY 1 DESC
--The charges are unique, soo no definite pattern was found. However, it would be interesting to know why customers with high total charges churned.

-- Let's see if there is a pattern with people who churned and have spent upwards of 7000
SELECT *
FROM kaggle.TelcoChurn
WHERE TotalCharges > 7000 AND Churn = 'Yes'
-- They all have Fibre Optic Internet Service, it is likely that that service is poor or maybe a competitor with better services and/or prices entered the market

-- The popular services with Senior citizens and their payment methods
SELECT SeniorCitizen, PhoneService, InternetService, Contract, PaymentMethod,
	COUNT (Churn) AS TotalChurn
FROM kaggle.TelcoChurn
GROUP BY SeniorCitizen, PhoneService, InternetService, Contract, PaymentMethod,Churn
HAVING Churn = 'Yes' AND SeniorCitizen = 1
ORDER BY 6 DESC
-- Most churn happened with Senior citizens with Fibre optic internet service, month-to-month contract, and electronic check payment method.
-- This further underscores our earlier observation about those options



