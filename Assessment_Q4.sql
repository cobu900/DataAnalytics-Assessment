-- Query to determine customer lifetime value (CLV) estimation
SELECT
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    COUNT(sa.id) AS total_transactions,
    ROUND(
        (COUNT(sa.id) / NULLIF(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 0)) 
        * 12 * 0.001 * AVG(sa.amount),
        2
    ) AS estimated_clv
FROM
    users_customuser uc
JOIN
    savings_savingsaccount sa ON sa.owner_id = uc.id
GROUP BY
    uc.id, uc.first_name, uc.last_name, uc.date_joined
ORDER BY
    estimated_clv DESC;
