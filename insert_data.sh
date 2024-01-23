#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

if [[ $YEAR != 'year' ]]
then
  
#VERIFICAR ID WINNER
ID_WINNER=$($PSQL "SELECT team_id from teams where name = '$WINNER'")
  if [[ -z $ID_WINNER ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
  fi
ID_WINNER=$($PSQL "SELECT team_id from teams where name = '$WINNER'")

#VERIFICAR ID OPPONENT
ID_OPPONENT=$($PSQL "SELECT team_id from teams where name = '$OPPONENT'")
  if [[ -z $ID_OPPONENT ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
  fi
ID_OPPONENT=$($PSQL "SELECT team_id from teams where name = '$OPPONENT'")

#INSERTAR GAME
echo $($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR, '$ROUND', $ID_WINNER, $ID_OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS)")
fi

done