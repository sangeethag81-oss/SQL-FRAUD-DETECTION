CREATE DATABASE fraud_detection_db;
USE fraud_detection_db;
CREATE TABLE transactions (
    step INT,
    type VARCHAR(20),
    amount DECIMAL(12,2),
    nameOrig VARCHAR(50),
    oldbalanceOrg DECIMAL(12,2),
    newbalanceOrig DECIMAL(12,2),
    nameDest VARCHAR(50),
    oldbalanceDest DECIMAL(12,2),
    newbalanceDest DECIMAL(12,2),
    isFraud TINYINT,
    isFlaggedFraud TINYINT
);

SELECT * FROM transactions LIMIT 10;
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) AS total_transactions
FROM transactions;
SELECT 
    isFraud,
    COUNT(*) AS count
FROM transactions
GROUP BY isFraud;
SELECT 
    ROUND(
        SUM(isFraud) * 100.0 / COUNT(*), 2
    ) AS fraud_percentage
FROM transactions;
SELECT 
    type,
    COUNT(*) AS fraud_cases
FROM transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY fraud_cases DESC;
SELECT 
    type,
    amount,
    nameOrig,
    nameDest
FROM transactions
WHERE isFraud = 1
ORDER BY amount DESC
LIMIT 10;
SELECT COUNT(*) AS missed_frauds
FROM transactions
WHERE isFraud = 1 AND isFlaggedFraud = 0;
SELECT *
FROM transactions
WHERE isFraud = 1
AND newbalanceOrig != oldbalanceOrg - amount;

