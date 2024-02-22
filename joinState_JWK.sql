/*______________________________________________________________________________
CODE DESCRIPTION: 

This SQL code (caseState_JWK.sql) creates a table in a miscellaneous database
containing toy data of a list of people and their demographics (i.e. age, race,
etc.), and then employs case statements to briefly analyze the data and report 
certain metrics.

Written by: Joshua W. Kern
Date: 02/20/24                                                                  
________________________________________________________________________________*/

/*______________________________________________________________________________
Step 0: Initialize the database
________________________________________________________________________________*/
DROP DATABASE IF EXISTS Misc;
CREATE DATABASE Misc;
USE Misc;



/*______________________________________________________________________________
Step 1: Initialize the data tables
________________________________________________________________________________*/
CREATE TABLE peopleInfo (
	gender TEXT,
	title TEXT,
	first_name TEXT,
	last_name TEXT,
	birth_date DATE,
	social_security_number VARCHAR(11),
	street_address TEXT,
	secondary_address TEXT,	
	post_code TEXT,
	city TEXT,
	state TEXT,
	latitude TEXT,	
	longitude TEXT,	
	phone_number TEXT,	
	email TEXT,	
	credit_card_type TEXT,
	credit_card_number TEXT,
	credit_card_expiration_date TEXT,
	iban TEXT,
	bank_account_number TEXT,
	swift_bic_number TEXT,
	company TEXT,
	job_title TEXT,
	PRIMARY KEY (social_security_number)
);


CREATE TABLE debtInfo (
        social_security_number VARCHAR(11),
        bank_account_number TEXT,
        debt FLOAT,
        apr_rate FLOAT,
        loanLength FLOAT,
        PRIMARY KEY (social_security_number)
);

/*______________________________________________________________________________
Step 2: Load the data into the tables
________________________________________________________________________________*/
LOAD DATA LOCAL INFILE '/home/jwkern/Downloads/people_data.csv' REPLACE INTO TABLE peopleInfo FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 rows;
LOAD DATA LOCAL INFILE '/home/jwkern/Downloads/debt_data.csv' REPLACE INTO TABLE debtInfo FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 rows;




/*______________________________________________________________________________
Step 3: Select subset of data and calculate properties
_______________________________________________________________________________*/
CREATE TABLE personalDebtTable AS SELECT first_name, last_name, birth_date, phone_number, email, street_address, city, state, credit_card_type, credit_card_number, credit_card_expiration_date
FROM peopleInfo
	JOIN debtInfo
	ON peopleInfo.social_security_number = debtInfo.social_security_number;


CREATE TABLE genTable AS SELECT YEAR(birth_date) AS birth_year,  
	CASE
		WHEN YEAR(birth_date) >= 1901 AND YEAR(birth_date) <= 1924 THEN "Greatest Generation"
		WHEN YEAR(birth_date) >= 1925 AND YEAR(birth_date) <= 1945 THEN "Silent Generation"
		WHEN YEAR(birth_date) >= 1946 AND YEAR(birth_date) <= 1964 THEN "Baby Boomers"
		WHEN YEAR(birth_date) >= 1965 AND YEAR(birth_date) <= 1980 THEN "Generation X"
		WHEN YEAR(birth_date) >= 1981 AND YEAR(birth_date) <= 1996 THEN "Millennials"
		WHEN YEAR(birth_date) >= 1997 AND YEAR(birth_date) <= 2012 THEN "Generation Z"
		WHEN YEAR(birth_date) >= 2013 AND YEAR(birth_date) <= 2025 THEN "Greatest Alpha"
		ELSE "None"
	END AS "generation"
FROM personalDebtTable;




SET @greatestCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Greatest Generation");
SET @silentCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Silent Generation");
SET @boomersCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Baby Boomers");
SET @genxCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Generation X");
SET @millennialsCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Millennials");
SET @genzCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Generation Z");
SET @alphaCount = (SELECT COUNT(*) FROM genTable WHERE generation = "Greatest Alpha");

SET @totalCount = @greatestCount + @silentCount + @boomersCount + @genxCount + @millennialsCount + @genzCount + @alphaCount;

SET @greatestPercent = ROUND(@greatestCount/@totalCount*100.0,2);
SET @silentPercent = ROUND(@silentCount/@totalCount*100.0,2);
SET @boomersPercent = ROUND(@boomersCount/@totalCount*100.0,2);
SET @genxPercent = ROUND(@genxCount/@totalCount*100.0,2);
SET @millennialsPercent = ROUND(@millennialsCount/@totalCount*100.0,2);
SET @genzPercent = ROUND(@genzCount/@totalCount*100.0,2);
SET @alphaPercent = ROUND(@alphaCount/@totalCount*100.0,2);

/*
SELECT YEAR(birth_date) AS birth_year,
        CASE
                WHEN YEAR(birth_date) >= 1901 AND YEAR(birth_date) <= 1924 THEN "Greatest Generation"
                WHEN YEAR(birth_date) >= 1925 AND YEAR(birth_date) <= 1945 THEN "Silent Generation"
                WHEN YEAR(birth_date) >= 1946 AND YEAR(birth_date) <= 1964 THEN "Baby Boomers"
                WHEN YEAR(birth_date) >= 1965 AND YEAR(birth_date) <= 1980 THEN "Generation X"
                WHEN YEAR(birth_date) >= 1981 AND YEAR(birth_date) <= 1996 THEN "Millennials"
                WHEN YEAR(birth_date) >= 1997 AND YEAR(birth_date) <= 2012 THEN "Generation Z"
                WHEN YEAR(birth_date) >= 2013 AND YEAR(birth_date) <= 2025 THEN "Greatest Alpha"
                ELSE "None"
        END AS "generation"
FROM peopleInfo
INTO OUTFILE '/var/lib/mysql-files/test.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/


SELECT @greatestPercent, @silentPercent, @boomersPercent, @genxPercent, @millennialsPercent, @genzPercent, @alphaPercent; 


/*______________________________________________________________________________
________________________________________________________________________________

--------------------------------------------------------------------------------
-----------------------------------THE END--------------------------------------
--------------------------------------------------------------------------------
________________________________________________________________________________
________________________________________________________________________________*/

