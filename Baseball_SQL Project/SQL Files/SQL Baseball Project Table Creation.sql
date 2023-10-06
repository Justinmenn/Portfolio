/*
	Justin Menninger
*/

/* 
**** NOTE **** ALL Data in this set is through the 2022 MLB season
	This script shows the creation of all tables used in the project.
	Once the tables are created, the data can then be imported from CSV files
*/

-- Delete Tables if they already exist
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Batting;
DROP TABLE IF EXISTS Pitching;
DROP TABLE IF EXISTS Fielding;
DROP TABLE IF EXISTS CollegePlaying;
DROP TABLE IF EXISTS Schools;

-- Creates a skeleton for a table containing various information on MLB players since the year 1871
CREATE TABLE People(
	playerID VARCHAR(50) PRIMARY KEY,
	birthYear INT,
	birthMonth INT,
	birthDay INT,
	birthCountry VARCHAR(50),
	birthState VARCHAR(50),
	birthCity VARCHAR(50),
	firstName VARCHAR(50),
	lastName VARCHAR(50),
	weight INT,
	heightInches INT,
	bats VARCHAR(1),
	throws VARCHAR(1),
	debut DATE,
	finalGame DATE,
	retroID VARCHAR(50),
	bbrefID VARCHAR(50)
	);

/*
-Creates a skeleton for a table containing baseball statistics of ONLY pitchers
-**Note** Each instance gives player stats for ONLY one specific year, so if a player played 
	  in the MLB for 10 years, there will be 10 instances involving that player 
*/
CREATE TABLE Pitching(
	playerID VARCHAR(50) REFERENCES People(playerID),
	yearID INT,
	stint INT,
	teamID VARCHAR(50),
	IgID VARCHAR(50),
	W INT,
	L INT,
	Games INT,
	GS INT,
	CG INT,
	SHO INT,
	SV INT,
	IpOuts INT,
	H INT,
	ER INT,
	HR INT,
	BB INT,
	SO INT,
	BAOpp FLOAT(3),
	ERA FLOAT(3),
	IBB FLOAT(3),
	WP INT,
	HBP INT,
	BK INT, 
	BFP INT,
	GF INT,
	R INT,
	SH INT,
	SF INT,
	GIDP INT	
);

/*
-Creates a skeleton for a table containing baseball statistics of ONLY fielders
-**Note** Each instance gives player stats for ONLY one specific year, so if a player played 
	  in the MLB for 10 years, there will be 10 instances involving that player 
*/
CREATE TABLE Fielding(
	playerID VARCHAR(50) REFERENCES People(playerID),
	yearID INT,
	stint INT,
	teamID VARCHAR(50),
	IgIG VARCHAR(50),
	POS VARCHAR(10),
	Games INT,
	GS INT,
	InnOuts INT,
	PO INT,
	Assists INT,
	E INT,
	DP INT,
	PB INT,
	WP INT,
	SB INT,
	CS INT,
	ZR INT
);

/*
-Creates a skeleton for a table containing baseball statistics of ONLY batters
-**Note** Each instance gives player stats for ONLY one specific year, so if a player played 
	  in the MLB for 10 years, there will be 10 instances involving that player 
*/
CREATE TABLE Batting(
	playerID VARCHAR(50) REFERENCES People(playerID),
	yearID VARCHAR(50),
	stint INT,
	teamID INT,
	IgID VARCHAR(50),
	Games INT,
	AB INT,
	R INT,
	H INT,
	Doubles INT,
	Triples INT,
	HR INT,
	RBI INT,
	SB INT,
	CS INT,
	BB INT,
	SO INT,
	IBB INT,
	HBP INT,
	SH INT,
	SF INT,
	GIDP INT
);

--Creates a skeleton for a table that shows the Name and Location of schools that MLB players have attended
CREATE TABLE Schools(
	schoolID VARCHAR(50) PRIMARY KEY,
	fullName VARCHAR(100),
	city VARCHAR(50),
	"state" VARCHAR(50),
	country VARCHAR(50)
);

--Creates a skeleton for a table shows the colleges of MLB players and the years they attended them
CREATE TABLE CollegePlaying(
	playerID VARCHAR(50) REFERENCES People(playerID),
	schoolID VARCHAR(50) REFERENCES Schools(schoolID),
	yearID INT
);

-- Viewing Data to ensure everything has loaded properly
/*

SELECT * FROM People LIMIT 100;
SELECT * FROM Pitching LIMIT 100;
SELECT * FROM Batting LIMIT 100;
SELECT * FROM Fielding LIMIT 100;
SELECT * FROM CollegePlaying LIMIT 100;
SELECT * FROM Schools LIMIT 100;

*/
