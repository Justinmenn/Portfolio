/*
	Justin Menninger
*/
/*
	All queries can be ran individually by selecting just the given query and then running the code
*/

/*
	Q1:
	
	First Let's look at some batting or "hitting" statistics
	
	Display the firstname, lastname, year, and # of homeruns of 
	the highest SINGLE SEASON homerun leaders since the year 1900 (the "modern" era of baseball)
*/
SELECT People.fullName, Batting.yearID, Batting.HR FROM People
INNER JOIN Batting ON People.playerID= Batting.playerID WHERE Batting.yearID > 1900
ORDER BY HR DESC LIMIT 20;

/*
	Q2:
	
	Display the firstname, lastname, and # of homeruns of 
	the highest CAREER homerun leaders
*/
SELECT People.fullName, SUM(Batting.Hr) AS HR_Total
FROM People INNER JOIN Batting ON People.playerID = Batting.playerID
GROUP BY People.playerID ORDER BY HR_Total DESC LIMIT 100;

/*
	Q3:
	
	Find the player who hit the most homeruns on each individual CURRENT MLB team in a single year.
	TeamID data can be seen on the website below.
	https://legacy.baseballprospectus.com/sortable/extras/team_codes.php?this_year=1950
	
	The long list of OR statements under the WHERE clause is to filter the result to
    only output data for the current MLB teams
	
	** Note ** Some teams have changed names and teamID's over the years but are still apart 
	of the same franchise. Data here is only for the 30 CURRENT MLB teams.
*/ 
SELECT DISTINCT ON (batting.teamID) batting.teamID, batting.hr, batting.yearID, People.fullName
FROM Batting INNER JOIN People ON batting.playerID = People.playerID 
WHERE   batting.teamID = 'ARI' OR batting.teamID = 'ATL' OR batting.teamID = 'BAL'
	 OR batting.teamID = 'BOS' OR batting.teamID = 'CHA' OR batting.teamID = 'CHN'
	 OR batting.teamID = 'CIN' OR batting.teamID = 'CLE' OR batting.teamID = 'COL'
	 OR batting.teamID = 'DET' OR batting.teamID = 'HOU' OR batting.teamID = 'KCA'
	 OR batting.teamID = 'LAA' OR batting.teamID = 'LAN' OR batting.teamID = 'MIA'
	 OR batting.teamID = 'MIL' OR batting.teamID = 'MIN' OR batting.teamID = 'NYA'
	 OR batting.teamID = 'NYN' OR batting.teamID = 'OAK' OR batting.teamID = 'PHI'
	 OR batting.teamID = 'PIT' OR batting.teamID = 'SDN' OR batting.teamID = 'SEA'
	 OR batting.teamID = 'SFN' OR batting.teamID = 'SLN' OR batting.teamID = 'TBA'
	 OR batting.teamID = 'TEX' OR batting.teamID = 'TOR' OR batting.teamID = 'WAS'
ORDER BY teamID, hr DESC;

/*
	Q4:
		
	For data on the top homerun hitter seasons over ALL MLB teams, past and present,
	run the following query.
*/
SELECT DISTINCT ON (batting.teamID) batting.teamID, batting.hr, batting.yearID, People.fullName
FROM Batting INNER JOIN People ON batting.playerID = People.playerID 
ORDER BY teamID, hr DESC;

/*
	Q5:
	
	How many different players have competed in the MLB?
*/
SELECT Count(*) AS Total_Number_Of_Players FROM(SELECT DISTINCT playerID FROM People);

/* 
	Q6:
	
	Find the most popular birth countries to be represented in the MLB, 
	and the total number of countries that have been represented
*/
SELECT birthCountry, COUNT(*) AS Country_Representation FROM People 
WHERE birthCountry IS NOT NULL GROUP BY birthCountry 
ORDER BY Country_Representation DESC;

SELECT COUNT(DISTINCT birthCountry) AS NumCountries FROM People WHERE birthCountry IS NOT NULL;

/*
	Q7:
	
	Find the full name, position, and birthYear of players who attended
	the University of Alabama and have competed in the MLB at some point.
	
	** NOTE ** Through some testing it seems that some of the school data is 
	outdated and only runs through ~2010 or so
*/

SELECT DISTINCT ON (People.fullName) People.fullName, collegeplaying.playerID, collegeplaying.yearID 
AS year_played_for, schools.fullname AS SchoolName
FROM People INNER JOIN collegeplaying ON People.playerID = collegeplaying.playerID 
INNER JOIN Schools ON collegeplaying.schoolID = schools.schoolID 
WHERE schools.schoolID = 'alabama' 
GROUP BY People.fullName, collegeplaying.playerID, collegeplaying.yearID, schools.fullname
ORDER BY People.fullName ASC;

/*
	Q8:
	
	A 'Thirty-thirty' or '30/30' season is a season in which a player obtained 30 stolen bases
	AND 30 homeruns. It is considered a very prestigious accomplishment as it requires both great
	speed and power.
	
	Find the fullname, year, # of homeruns, and # of stolen bases of all 30/30 seasons in MLB history
*/

SELECT People.fullName, batting.yearID, batting.hr, batting.sb 
FROM Batting INNER JOIN People ON batting.playerID = People.playerID 
WHERE batting.hr >= 30 AND batting.sb >= 30 
ORDER BY batting.yearID DESC;

/*
	Q9:
	
	Now let's look at some pitching statistics
	
	As a general rule, to be "qualified" for pitching stats, a pitcher must have pitched 
	at least 1 inning for each team game played. For a full season, this is 162 games or innings
	pitched. This loose rule is to prevent players who have only pitched a small amount of innings
	to be considered for "percantage-based" stats. For instance, if a pitcher pitches his first game 
	50 games into the season and doesn't allow any runs, then his ERA will be 0.00. However, it isn't
	fair to compare this person to someone who has been pitching all year along. 
	
	So, among "Qualified" pitchers, who are the ERA leaders since the year 1960? ERA stands for
	"earned runs allowed", so the lower the ERA is, the better for the pitcher.
	
	** Note the column 'ipouts' does not denote the number of innings pitched, but the number of
	outs recorded. Since there are 3 outs in an inning a qualified player must have a minimum
	of 162*3 = 486 ipouts **
*/

SELECT People.fullName, pitching.yearID, pitching.era, pitching.ipouts, pitching.teamID
FROM Pitching INNER JOIN People ON pitching.playerID = People.playerID 
WHERE pitching.ipouts >= 486 AND pitching.yearID >= 1960 
ORDER BY pitching.era ASC LIMIT 100;

/* 
	Q10:
	
	Which pitcher has the most career hit-by-pitch in MLB history? And what is that players
	birth year, birth country, and pitching arm?
*/

SELECT P.fullName, SUM(pitching.hbp) AS hbp_total, P.birthyear, P.birthcountry, P.throws
FROM People P INNER JOIN pitching ON P.playerID = pitching.playerID
WHERE pitching.hbp IS NOT NULL
GROUP BY P.playerID ORDER BY hbp_total DESC LIMIT 100;

/*
	Q11:
	
	Now let's look at some fielding satistics
	
	Find all the players who played in the field in all 162 games of a season at the 
	same position since 2015. Also find how many errors each of those players had.
*/

SELECT P.fullName, fielding.games, fielding.e, fielding.yearID
FROM People P INNER JOIN fielding ON P.playerID = fielding.playerID
WHERE fielding.games = 162 AND fielding.yearID >= 2015
ORDER BY fielding.yearID DESC LIMIT 100;

/*
	Q12:
	
	Who are the top 100 players that have committed the most errors 
	in a single season between the year 2000 and 2010?
*/

SELECT P.fullName,fielding.e, fielding.yearID
FROM People P INNER JOIN fielding ON P.playerID = fielding.playerID
WHERE fielding.yearID >= 2000 AND fielding.yearID <= 2015 AND fielding.e IS NOT NULL
ORDER BY fielding.e DESC LIMIT 100;