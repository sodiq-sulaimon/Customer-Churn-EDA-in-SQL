-- View the table columns
SELECT TOP (100) *
FROM kaggle.TelcoChurn

-- Number of distinct Customers
SELECT COUNT (DISTINCT customerID) AS TotalCustomers
FROM kaggle.TelcoChurn

-- Distint Churn categories
SELECT DISTINCT Churn AS ChurnCat
FROM kaggle.TelcoChurn

-- Retained Vs Churned Customers (in the last month)

SELECT 
	CASE	
		WHEN Churn = 'Yes' THEN 'Churned'
		ELSE 'Retained'
		END AS Status,
	COUNT (*) AS TotalNumber,
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
--HAVING Churn = 'Yes'

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

-- Payment Method used by Churned SeniorCitizen
SELECT 
CASE	
	WHEN Churn = 'Yes' THEN 'Churned'
	ELSE 'Retained'
	END AS Status,
	COUNT (SeniorCitizen) AS TotalSeniorCitizen,
	PaymentMethod
FROM kaggle.TelcoChurn
GROUP BY SeniorCitizen, Churn, PaymentMethod
HAVING SeniorCitizen = 1 AND Churn = 'Yes'
ORDER BY 2 DESC

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
ORDER BY 1

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
	Churn AS Churned,
	COUNT (OnlineSecurity) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, OnlineSecurity
HAVING OnlineSecurity NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Online Backup
SELECT 
	OnlineBackup,
	Churn AS Churned,
	COUNT (OnlineBackup) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, OnlineBackup
HAVING OnlineBackup NOT LIKE 'No Internet Service'
ORDER BY 1
--Customers with Online backup are less likely to churn

-- Churn by customers with Device Protection
SELECT 
	DeviceProtection,
	Churn AS Churned,
	COUNT (DeviceProtection) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, DeviceProtection
HAVING DeviceProtection NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Tech Support
SELECT 
	TechSupport,
	Churn AS Churned,
	COUNT (TechSupport) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, TechSupport
HAVING TechSupport NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Streaming TV
SELECT 
	StreamingTV,
	Churn AS Churned,
	COUNT (StreamingTV) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, StreamingTV
HAVING StreamingTV NOT LIKE 'No Internet Service'
ORDER BY 1

-- Churn by customers with Streaming Movies
SELECT 
	StreamingMovies,
	Churn AS Churned,
	COUNT (StreamingMovies) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, StreamingMovies
HAVING StreamingMovies NOT LIKE 'No Internet Service'
ORDER BY 1

--Churn by Contract Type
SELECT 
	Contract,
	Churn AS Churned,
	COUNT (Contract) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, Contract
ORDER BY 1

-- Churn by Billing methods
SELECT 
	PaperlessBilling,
	Churn AS Churned,
	COUNT (PaperlessBilling) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, PaperlessBilling
ORDER BY 1

-- Churn by Payment methods
SELECT 
	PaymentMethod,
	Churn AS Churned,
	COUNT (PaymentMethod) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, PaymentMethod
ORDER BY 1

-- Churn by Total Charges
SELECT 
	TotalCharges,
	Churn AS Churned,
	COUNT (TotalCharges) AS NumOfCustomers
FROM kaggle.TelcoChurn
GROUP BY Churn, TotalCharges
ORDER BY 1 DESC

-- It would be interesting to know why this customer churned
SELECT *
FROM kaggle.TelcoChurn
WHERE TotalCharges = 8684.8

-- It would be interesting to know why these customers churned
SELECT *
FROM kaggle.TelcoChurn
WHERE TotalCharges > 7000 AND Churn = 'Yes'
-- They all have Fibre Optic Internet Service, it is likely that that service is poor


SELECT TOP (20) *
FROM kaggle.TelcoChurn


