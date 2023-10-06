/*
	Justin Menninger
*/

/*
	A lot of data is these tables is unnecessary for the puposes of this project, so we 
	will drop these columns to made the tables more clear and concise. We will also normalize
	aspects of certain tables
*/

ALTER TABLE People 
	DROP COLUMN debut,
	DROP COLUMN finalGame,
	DROP COLUMN retroID,
	DROP COLUMN bbrefID;
 
-- Combines first and last name data into one 'fullname'column
ALTER TABLE People
ADD fullName VARCHAR(60) GENERATED ALWAYS AS (firstName ||' '|| lastName) STORED;

ALTER TABLE Batting
	DROP COLUMN stint,
	DROP COLUMN SH,
	DROP COLUMN SF,
	DROP COLUMN GIDP;
	
ALTER TABLE Pitching
	DROP COLUMN stint,
	DROP COLUMN BK,
	DROP COLUMN BFP,
	DROP COLUMN GF,
	DROP COLUMN SH,
	DROP COLUMN SF,
	DROP COLUMN GIDP;
	
ALTER TABLE Fielding
	DROP COLUMN stint,
	DROP COLUMN WP,
	DROP COLUMN SB,
	DROP COLUMN CS,
	DROP COLUMN ZR;

-- Viewing data to ensures changes were made properly
/*

SELECT * FROM People LIMIT 100;
SELECT * FROM Pitching LIMIT 100;
SELECT * FROM Batting LIMIT 100;
SELECT * FROM Fielding LIMIT 100;
SELECT * FROM CollegePlaying LIMIT 100;
SELECT * FROM Schools LIMIT 100;

*/

	
