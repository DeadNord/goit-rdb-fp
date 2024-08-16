SELECT 
    e.entity_name, 
    e.country_code, 
    AVG(CAST(NULLIF(c.Number_rabies, '') AS DECIMAL(10,2))) AS avg_rabies,
    MIN(CAST(NULLIF(c.Number_rabies, '') AS DECIMAL(10,2))) AS min_rabies,
    MAX(CAST(NULLIF(c.Number_rabies, '') AS DECIMAL(10,2))) AS max_rabies,
    SUM(CAST(NULLIF(c.Number_rabies, '') AS DECIMAL(10,2))) AS sum_rabies
FROM cases c
JOIN entities e ON c.entity_id = e.entity_id
WHERE c.Number_rabies IS NOT NULL
GROUP BY e.entity_name, e.country_code
ORDER BY avg_rabies DESC
LIMIT 10;
