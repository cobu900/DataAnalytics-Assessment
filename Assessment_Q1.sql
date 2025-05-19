
-- Query to find customers having at least one funded savings and investment plan 
-- Results sorted by total deposits (from the highest to the lowest)
-- First, create temporary tables for the heavy operations
CREATE TEMPORARY TABLE temp_savings AS
SELECT owner_id, COUNT(DISTINCT id) AS savings_count, SUM(amount) AS total_deposits
FROM savings_savingsaccount 
WHERE amount > 0
GROUP BY owner_id;

CREATE TEMPORARY TABLE temp_investments AS
SELECT owner_id, COUNT(DISTINCT id) AS investment_count
FROM plans_plan
WHERE is_regular_savings  = 1
GROUP BY owner_id;

-- Now join the pre-aggregated results
SELECT
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    ts.savings_count,
    ti.investment_count,
    ts.total_deposits AS total_deposits
FROM
    users_customuser uc
JOIN
    temp_savings ts ON ts.owner_id = uc.id
JOIN
    temp_investments ti ON ti.owner_id = uc.id
ORDER BY 
    ts.total_deposits DESC;

-- Clean up
DROP TEMPORARY TABLE IF EXISTS temp_savings;
DROP TEMPORARY TABLE IF EXISTS temp_investments;
-- Query to find customers having at least one funded savings and investment plan 
-- Results sorted by total deposits (from the highest to the lowest)
-- First, create temporary tables for the heavy operations
CREATE TEMPORARY TABLE temp_savings AS
SELECT owner_id, COUNT(DISTINCT id) AS savings_count, SUM(amount) AS total_deposits
FROM savings_savingsaccount 
WHERE amount > 0
GROUP BY owner_id;

CREATE TEMPORARY TABLE temp_investments AS
SELECT owner_id, COUNT(DISTINCT id) AS investment_count
FROM plans_plan
WHERE is_regular_savings  = 1
GROUP BY owner_id;

-- Now join the pre-aggregated results
SELECT
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    ts.savings_count,
    ti.investment_count,
    ts.total_deposits AS total_deposits
FROM
    users_customuser uc
JOIN
    temp_savings ts ON ts.owner_id = uc.id
JOIN
    temp_investments ti ON ti.owner_id = uc.id
ORDER BY 
    ts.total_deposits DESC;

-- Clean up
DROP TEMPORARY TABLE IF EXISTS temp_savings;
DROP TEMPORARY TABLE IF EXISTS temp_investments;
