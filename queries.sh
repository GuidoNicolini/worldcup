#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.


# $($PSQL "")
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo $($PSQL "select SUM(winner_goals + opponent_goals) from games")

echo -e "\nAverage number of goals in all games from the winning teams:"
echo $($PSQL "select AVG(winner_goals) from games")

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo $($PSQL "select ROUND(AVG(winner_goals),2) from games;")

echo -e "\nAverage number of goals in all games from both teams:"
echo $($PSQL "select AVG(winner_goals + opponent_goals) from games;")

echo -e "\nMost goals scored in a single game by one team:"
echo $($PSQL "select max(greatest(winner_goals,opponent_goals)) from games")

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo $($PSQL "select count(*) as cuenta from games where winner_goals > 2")

echo -e "\nWinner of the 2018 tournament team name:"
echo $($PSQL "select name from teams RIGHT JOIN games ON teams.team_id = games.winner_id where round = 'Final' AND  year = 2018")

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo $($PSQL "select distinct(name) from teams as t FULL JOIN games as g ON t.team_id IN (g.winner_id, g.opponent_id)  where round = 'Eighth-Final' AND year = 2014")

echo -e "\nList of unique winning team names in the whole data set:"
echo $($PSQL "select distinct(name) from teams as t RIGHT JOIN games as g ON t.team_id= g.winner_id ORDER BY name ASC")

echo -e "\nYear and team name of all the champions:"
echo $($PSQL "select year,name from teams as t RIGHT JOIN games as g ON t.team_id= g.winner_id where round = 'Final' ORDER BY year")

echo -e "\nList of teams that start with 'Co':"
echo $($PSQL "select name from teams where name LIKE 'Co%'")
