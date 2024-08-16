DELIMITER //

CREATE FUNCTION IF NOT EXISTS calculate_year_diff(input_year INT) 
RETURNS INT
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, CONCAT(input_year, '-01-01'), CURDATE());
END //

DELIMITER ;


SELECT 
    e.entity_name,
    e.country_code,
    c.year,
    calculate_year_diff(c.year) AS year_diff
FROM cases c
JOIN entities e ON c.entity_id = e.entity_id;
