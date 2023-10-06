# MLB Baseball SQL Project

## Description
Baseball has always been one of my passions. I grew up playing and watching the sport, and I have attended countless MLB games in my life. Baseball is a statistics-driven sports, and that aspect of it has always fascinated me. For this project I have taken it upon myself to answer 12 questions that I have proposed to myself. All questions were answered by using six data tables that contain MLB data. The project contains three SQL file scripts that I wrote. PgAdmin4 software and postgreSQL DBMS were used for querying. Finally, the Query Results folder contains the csv files of the results from each of the queries. Their labeling is matched within the comments of the querying SQL file.

### Data Tables 
**This project uses six tables in the form of Excel files:**
- The "Batting" data table contains hitting statistics on every person to ever play in the MLB (1871-2022). There is a data entry for each player and each season in which they played. So if a player played in the league for 10 years, there will be 10 separate entries for that player. Each player is uniquely identifiable by their "playerID", the first column in the table.
- The "Fielding" data table is exactly the same as the "Batting" table expect is has fielding statistics for all players.
- The "Pitching" data table is exactly the same as the "Batting" and "Pitching" table expect is has pitching statistics for all pitchers in the MLB.
- The "People" data table contains personal and demographical data on MLB players. This table also includes each players "bbrefID" which can be used used to see their baseball reference page, an extremely popular website for looking at player statistics.
- The "Schools" data table contains a list of all colleges and universities that MLB players have come from. Each school is uniquely by its "schoolID".
- The "CollegePlaying" data table shows where each MLB went to college, if they did go to any at all. It also shows the year in which they attended their school.

The "Batting", "Fielding", "Pitching", "People", and "CollegePlaying" data sets can all be linked using the "playerID" column.
The "Schools" and "CollegePlaying" data sets can be linked using the "schoolD" column.

### SQL Files
**This Project uses three SQL scripts to preform all necessary tasks:**
- The "SQL Baseball Project Table Creation" SQL file contains the skeleton for creating each of the six tables.
- Once the data is imported into these tables, the "Baseball Project Cleaning Data" SQL file wrangles and cleans the data.
- The "Baseball Project Queries" SQL file contains all of the queries for answering the questions I asked myself.

**Each SQL file has detailed comments in the code to further describe what the code is doing. The questions asked for each query can also be seen in the comments of the code in the "Baseball Project Queries" SQL file**
