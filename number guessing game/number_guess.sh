#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
SECRET=$((1 + RANDOM % 1000))
echo $SECRET
COUNT_GUESSES=1
echo -e "\nEnter your username:\n"
read USERNAME
FIND_IN_DB=$($PSQL "SELECT COUNT(game_id) FROM games WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE username='$USERNAME'")
if [[ $FIND_IN_DB -ge $COUNT_GUESSES ]]
then
  echo "Welcome back, $USERNAME! You have played $FIND_IN_DB games, and your best game took $BEST_GAME guesses."
else
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
fi

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  GUESS_NUMBER
}
GUESS_NUMBER(){
  echo "Guess the secret number between 1 and 1000:"
  read TRY
  if [[ $TRY -eq $SECRET ]]
  then
    echo "You guessed it in $COUNT_GUESSES tries. The secret number was $SECRET. Nice job!"
  fi
  if [[ ! $TRY =~ ^[0-9]+$ ]]
  then
    ((COUNT_GUESSES++))
    MAIN_MENU "That is not an integer, guess again:"
  fi
  if [[ $TRY -gt $SECRET ]]
  then
    ((COUNT_GUESSES++))
    MAIN_MENU "It's higher than that, guess again:"
  fi
  if [[ $TRY -lt $SECRET ]]
  then
    ((COUNT_GUESSES++))
    MAIN_MENU "It's lower than that, guess again:"
  fi
}
MAIN_MENU
INSERT_VALUES=$($PSQL "INSERT INTO games(username, number_of_guesses) VALUES('$USERNAME', $COUNT_GUESSES)")
