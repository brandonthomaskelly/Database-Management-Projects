-- BRANDON KELLY
-- CPSC 321-02
-- HW4
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Border;

CREATE TABLE Country(
   code VARCHAR(4) NOT NULL,
   country_name TEXT NOT NULL,
   gdp INT NOT NULL,
   inflation DECIMAL(18,1) NOT NULL,
   PRIMARY KEY (code)
) ENGINE = InnoDB;

CREATE TABLE Province(
   province_name VARCHAR(255) NOT NULL,
   country VARCHAR(4) NOT NULL,
   area INT NOT NULL,
   PRIMARY KEY (province_name, country),
  FOREIGN KEY(country) REFERENCES Country(code)
) ENGINE = InnoDB;

CREATE TABLE City(
   city_name VARCHAR(255) NOT NULL,
   province VARCHAR(255) NOT NULL,
   country VARCHAR(4) NOT NULL,
   population int NOT NULL,
   PRIMARY KEY (city_name, province,country),
   FOREIGN KEY(province, country) REFERENCES Province(province_name, country)
) ENGINE = InnoDB;

CREATE TABLE Border(
   country1 VARCHAR(4) NOT NULL,
   country2 VARCHAR(4) NOT NULL,
   border_length int NOT NULL,
   PRIMARY KEY (country1, country2),
   FOREIGN KEY(country1) REFERENCES Country(code),
   FOREIGN KEY(country2) REFERENCES Country(code)
) ENGINE = InnoDB;


INSERT INTO Country(code, country_name, gdp, inflation)VALUES
("US", "United States of America", 46900, 3.8),
("IRE", "Ireland", 1000000, 7.9),
("CAN", "Canada", 80000000, 6.5);

INSERT INTO Province(province_name, country, area) VALUES
("Washington", "US", 20000),
("Munster", "IRE", 10000),
("Ontario", "CAN", 500000);

INSERT INTO City(city_name, province, country, population)VALUES
("Vancouver", "Ontario", "CAN", 2345),
("Dublin", "Munster", "IRE", 2552),
("Toronto", "Ontario", "CAN", 43222);

INSERT INTO Border(country1, country2, border_length)VALUES
("US", "IRE", 12200),
("IRE", "CAN", 39012),
("CAN", "US", 2893);

-- Query 1
SELECT c.country_name
FROM Country c
WHERE c.gdp > 1000 AND c.inflation < 10.0;

-- Query 2
SELECT p.province_name
FROM Province p INNER JOIN City c ON p.province_name = c.province
WHERE c.population > 1000;


-- Query 3
SELECT SUM(p.area)
FROM Province p INNER JOIN Country c ON p.country  = c.code
WHERE c.code = "IRE";

-- Query 4
SELECT MIN(c.gdp), MAX(c.gdp), AVG(c.gdp), MIN(c.inflation), MAX(c.inflation), AVG(c.inflation)
FROM Country c;

-- Query 5
SELECT COUNT(*)
FROM City c INNER JOIN Country cc ON c.country  = cc.code
WHERE cc.code = "IRE";

-- Query 6
SELECT DISTINCT *
FROM Border b JOIN Country c1 ON b.country1 = c1.code JOIN Country c2 ON b.country2 = c2.code
WHERE c1.gdp < c2.gdp AND c1.inflation > c2.inflation;

-- Query 7
SELECT COUNT(*), AVG(b.border_length)
FROM Border b
WHERE b.country1 = "US";
