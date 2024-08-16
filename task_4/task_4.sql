SELECT 
    e.entity_name,
    e.country_code,
    c.year,
    CONCAT(c.year, '-01-01') AS start_date,
    CURDATE() AS current_dt,
    TIMESTAMPDIFF(YEAR, CONCAT(c.year, '-01-01'), CURDATE()) AS year_diff
FROM cases c
JOIN entities e ON c.entity_id = e.entity_id;
