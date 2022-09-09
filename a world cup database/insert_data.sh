#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games,teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT  WINNER_G  OPPONENT_G
do

TEAMS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
if [[ $WINNER != "winner" ]]
then
   if [[ -z $TEAMS ]]
   then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      
   fi
fi

TEAM2=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
if [[ $OPPONENT != "opponent" ]]
then
   if [[ -z $TEAM2 ]]
   then
      insertando_equipo=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
     
   fi
fi

team_id_winner=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
team_id_opponent=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

if [[ -n $team_id_winner || -n $team_id_opponent ]]
then
  if [[ $YEAR != "year" ]]
  then
    in_games=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $team_id_winner, $team_id_opponent, $WINNER_G, $OPPONENT_G)")
     
  fi

fi

done
