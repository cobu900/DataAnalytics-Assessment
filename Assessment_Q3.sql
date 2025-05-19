-- Query to get all active savings and investment accounts with no inflow in the last 365 days

SELECT 
    id AS plan_id,
    owner_id,
    'Savings' AS type,
    last_returns_date,
    DATEDIFF(CURDATE(), last_returns_date) AS inactivity_days
FROM 
    savings_savingsaccount
WHERE 
    last_returns_date < CURDATE() - INTERVAL 365 DAY

UNION ALL

SELECT 
    id AS plan_id,
    owner_id,
    'Investment' AS type,
    last_returns_date,
    DATEDIFF(CURDATE(), last_returns_date) AS inactivity_days
FROM 
    plans_plan
WHERE 
    is_a_fund = 1
    AND last_returns_date < CURDATE() - INTERVAL 365 DAY;