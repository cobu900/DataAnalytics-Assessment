-- Query to analyze customers transactions in a bid to segment them
-- Step 1: Create temporary table with pre-calculated monthly averages
CREATE TEMPORARY TABLE temp_customer_stats AS
SELECT 
    sa.owner_id AS customer_id,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT DATE_FORMAT(sa.transaction_date, '%Y-%m')) AS active_months,
    COUNT(*) / COUNT(DISTINCT DATE_FORMAT(sa.transaction_date, '%Y-%m')) AS transactions_per_month
FROM 
    savings_savingsaccount sa
WHERE 
    sa.transaction_date IS NOT NULL
GROUP BY 
    sa.owner_id;

-- Step 2: Categorize and summarize the results
SELECT 
    CASE 
        WHEN transactions_per_month >= 10 THEN 'High Frequency'
        WHEN transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    temp_customer_stats
GROUP BY 
    frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;

-- Clean up
DROP TEMPORARY TABLE IF EXISTS temp_customer_stats;