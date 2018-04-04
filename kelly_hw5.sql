-- Brandon Kelly
-- CPSC 321 - 02
-- Homework 5: More Database Queries
-- Description: More queries involving borders and cities

SET sql_mode = STRICT_ALL_TABLES;

-- Drops the given tables if they exist for clean slate
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Border;

-- Table creation for countries
CREATE TABLE Country(
   code VARCHAR(4) NOT NULL, -- Country code variable
   country_name TEXT NOT NULL, -- Country name variable
   gdp INT NOT NULL, -- GDP variable
   inflation DECIMAL(18,1) NOT NULL, -- Inflation variable
   PRIMARY KEY (code) -- PK definition
) ENGINE = InnoDB;

-- Table creation for provinces
CREATE TABLE Province(
   province_name VARCHAR(255) NOT NULL, -- Province name variable
   country VARCHAR(4) NOT NULL, -- Country name variable
   area INT NOT NULL, -- Area variable
   PRIMARY KEY (province_name, country), -- PK and FK definitions
   FOREIGN KEY(country) REFERENCES Country(code)
) ENGINE = InnoDB;

-- Table creation for cities
CREATE TABLE City(
   city_name VARCHAR(255) NOT NULL, -- City name variable
   province VARCHAR(255) NOT NULL, -- Province name variable
   country VARCHAR(4) NOT NULL, -- Country name variable
   population int NOT NULL, -- City population
   PRIMARY KEY (city_name, province,country), -- PK and FK definitions
   FOREIGN KEY(province, country) REFERENCES Province(province_name, country)
) ENGINE = InnoDB;

-- Table creation for borders
CREATE TABLE Border(
   country1 VARCHAR(4) NOT NULL, -- Both country creation
   country2 VARCHAR(4) NOT NULL,
   border_length int NOT NULL, -- Border length is an int
   PRIMARY KEY (country1, country2), -- PK and FK definitions
   FOREIGN KEY(country1) REFERENCES Country(code),
   FOREIGN KEY(country2) REFERENCES Country(code)
) ENGINE = InnoDB;

-- Populating the just created tables with data (questionably accurate data)
INSERT INTO Country(code, country_name, gdp, inflation)VALUES
("US", "United States of America", 46900, 3.8),
("IRE", "Ireland", 1000000, 7.9),
("CAN", "Canada", 80000000, 6.5);

INSERT INTO Province(province_name, country, area) VALUES
("Washington", "US", 20000),
("Munster", "IRE", 10000),
("Ontario", "CAN", 500000),
("British Columbia", "CAN", 93823),
("Alberta", "CAN", 500000);

INSERT INTO City(city_name, province, country, population)VALUES
("Vancouver", "Ontario", "CAN", 2345),
("Dublin", "Munster", "IRE", 2552),
("Toronto", "Ontario", "CAN", 43222),
("Richland", "Washington", "US", 90323),
("Pasco", "Washington", "US", 124921),
("Kennewick", "Washington", "US", 6503341),
("Spokane", "Washington", "US", 650122),
("Portland", "Oregon", "US", 6503342),
("Canadian City", "Canadian Province", "CAN", 65012),
("Maple Syrup Land", "Ontario", "CAN", 600042);

INSERT INTO Border(country1, country2, border_length)VALUES
("US", "CAN", 10000),
("IRE", "US", 1000),
("CAN", "US", 39023),
("IRE", "CAN", 2874);


-- 3
SELECT c.code, c.inflation, c.gdp, SUM(c1.population)
FROM Country c JOIN City c1 WHERE c1.country = c.code
GROUP BY c.code;

-- 4
SELECT p.province_name, p.area, SUM(c.population)
FROM Province p, City c
WHERE p.province_name = c.province
GROUP BY p.province_name
HAVING SUM(c.population) > 1000000;

-- 5
SELECT c1.code, COUNT(c2.country)
FROM Country c1 JOIN City c2 ON c1.code = c2.country
GROUP BY c1.code
HAVING COUNT(c2.country) > 0
ORDER BY COUNT(c2.country) DESC;


-- 6
SELECT c.code, SUM(p.area)
FROM Province p JOIN Country c ON p.country = c.code
GROUP BY c.code
ORDER BY SUM(p.area) DESC;

-- 7
SELECT c1.code, COUNT(p.province_name)
FROM Country c1 JOIN Province p ON p.country = c1.code JOIN City c2 ON p.province_name = c2.province
GROUP BY c1.code
HAVING COUNT(p.province_name) >= 1 AND COUNT(c2.country) > 4;

-- 8
CREATE VIEW assoc_borders AS
SELECT *
FROM Border
UNION ALL
SELECT country2 AS country1, country1 AS country2, border_length
FROM Border;

-- 9
SELECT DISTINCT c.code, AVG(c2.gdp), AVG(c2.inflation)
FROM Country c JOIN assoc_borders ab ON c.code = ab.country1 JOIN Country c2 ON c2.code = ab.country2
GROUP BY c.code;
