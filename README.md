___________________________________________________________________________________________________________________________________________________________________
___________________________________________________________________________________________________________________________________________________________________
___________________________________________________________________________________________________________________________________________________________________
# joinState_SQL

___________________________________________________________________________________________________________________________________________________________________
GENERAL DESCRIPTION:
This is an SQL script in which personal contact info from one database is extracted using joins with another relational database that contains some information regarding the people who have financial debt. The new joined table is then analyzed for the percentage of each generation that holds any toy debt.   

___________________________________________________________________________________________________________________________________________________________________
DATA DESCRIPTION:
In this example, the demographic data being used has been generated from the online source https://generate-random.org/person-identity-generator. 

An example schema of each persons information is given below: 

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



___________________________________________________________________________________________________________________________________________________________________
CODE DESCRIPTION:
This SQL code (joinState.sql) imports the data (people_data.csv, debt_data.csv), and uses a join statement to extract the contact info for the people listed to have debt. Then case statements are used to calculate the percentage of patients with debt who are in a particular generation bin (e.g. Baby Boomers, Millennials, etc.) based on the following age brackets:

    Greatest Generation (1901-1924) ...
    Silent Generation (1925-1945) ...
    Baby Boomers (1946-1964) ...
    Generation X (1965-1980) ...
    Millennials (1981-1996) ...
    Generation Z (1997-2012) ...
    Generation Alpha (2013-2025)

___________________________________________________________________________________________________________________________________________________________________
RUNNING THE CODE:
1) Download the data (people_data.csv and debt_data.csv) and the SQL script (joinState_JWK.sql)

2) In a terminal, cd into the directory that now contains the data and the script

3) In joinState.sql, change the file path on lines 65 and 66 from "/home/jwkern/Downloads/" to point to your local directory containing people_data.csv and debt_data.csv

4) Run the script by typing the following into the command line:

            mysql --local-infile=1 -u username -p password < joinState_JWK.sql

(P.S. don't forget to change the username and password to your mySQL credentials)

4.1) If you wish to save the output in a .txt file, instead run the script as:
      
            mysql --local-infile=1 -u username -p password < joinState_JWK.sql > output.txt


___________________________________________________________________________________________________________________________________________________________________
___________________________________________________________________________________________________________________________________________________________________
___________________________________________________________________________________________________________________________________________________________________
