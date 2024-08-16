CREATE TABLE IF NOT EXISTS entities (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name TEXT NOT NULL,
    country_code TEXT NOT NULL,
    UNIQUE(entity_name, country_code)
);

INSERT INTO entities (entity_name, country_code)
SELECT DISTINCT Entity, Code FROM infectious_cases;

CREATE TABLE IF NOT EXISTS cases_temp (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT,
    year INT NOT NULL,
    number_yaws TEXT NULL,
    polio_cases TEXT NULL,
    cases_guinea_worm TEXT NULL,
    number_rabies TEXT NULL,
    number_malaria TEXT NULL,
    number_hiv TEXT NULL,
    number_tuberculosis TEXT NULL,
    number_smallpox TEXT NULL,
    number_cholera_cases TEXT NULL,
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);

INSERT INTO cases_temp (entity_id, year, number_yaws, polio_cases, cases_guinea_worm, number_rabies, number_malaria, number_hiv, number_tuberculosis, number_smallpox, number_cholera_cases)
SELECT e.entity_id,
       o.Year,
       o.Number_yaws,
       o.polio_cases,
       o.cases_guinea_worm,
       o.Number_rabies,
       o.Number_malaria,
       o.Number_hiv,
       o.Number_tuberculosis,
       o.Number_smallpox,
       o.Number_cholera_cases
FROM infectious_cases o
JOIN entities e ON o.Entity = e.entity_name AND o.Code = e.country_code;


CREATE TABLE IF NOT EXISTS cases (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT,
    year INT NOT NULL,
    number_yaws TEXT NULL,
    polio_cases INT NULL,
    cases_guinea_worm INT NULL,
    number_rabies TEXT NULL,
    number_malaria TEXT NULL,
    number_hiv TEXT NULL,
    number_tuberculosis TEXT NULL,
    number_smallpox INT NULL,
    number_cholera_cases TEXT NULL,
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);


INSERT INTO cases (entity_id, year, number_yaws, polio_cases, cases_guinea_worm, number_rabies, number_malaria, number_hiv, number_tuberculosis, number_smallpox, number_cholera_cases)
SELECT entity_id,
       year,
       NULLIF(number_yaws, '') AS number_yaws,
       CAST(NULLIF(polio_cases, '') AS UNSIGNED) AS polio_cases,
       CAST(NULLIF(cases_guinea_worm, '') AS UNSIGNED) AS cases_guinea_worm,
       NULLIF(number_rabies, '') AS number_rabies,
       NULLIF(number_malaria, '') AS number_malaria,
       NULLIF(number_hiv, '') AS number_hiv,
       NULLIF(number_tuberculosis, '') AS number_tuberculosis,
       CAST(NULLIF(number_smallpox, '') AS UNSIGNED) AS number_smallpox,
       NULLIF(number_cholera_cases, '') AS number_cholera_cases
FROM cases_temp;


DROP TABLE cases_temp;
