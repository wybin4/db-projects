#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

STRING_LENGTH() {

STRING="$1"
echo "$STRING" | wc --chars | while read CHAR_COUNT
do 
  echo $(($CHAR_COUNT -1))
done
}

WELCOME_MENU() {

  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nEnter your username:"
  fi

  read USER_NAME

  USER_NAME_LENGTH=$(STRING_LENGTH $USER_NAME)
  if [[ $USER_NAME_LENGTH == 0 ]]
  then
    WELCOME_MENU -e "\nUsername should not be empty!"
  elif [[ $USER_NAME_LENGTH > 30 ]]
  then
    WELCOME_MENU -e "\nUsername is too long!"
  fi
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
  if [[ $USER_ID ]]
  then
    
    TOTAL_GAMES=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    BEST_GAME=$($PSQL"SELECT MIN(game_guesses) FROM games WHERE user_id=$USER_ID")
    echo -e "\nWelcome back, $USER_NAME! You have played $TOTAL_GAMES games, and your best game took $BEST_GAME guesses."
  else
    
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(user_name) VALUES('$USER_NAME')")
    if [[ $INSERT_USER_RESULT = "INSERT 0 1" ]]
    then 
      echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
    else
      echo -e "\nSomething went wrong while registering a new user!"
    fi
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE user_name='$USER_NAME'")
  fi

  START_GAME
}

START_GAME() {
  RANDOM_NUMBER=$(( RANDOM % 1000 + 1 ))
  GUESS_COUNT=0
  GUESS
}

GUESS() { 
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
  echo -e "\nGuess the secret number between 1 and 1000:"
  fi 

  read USER_GUESS 

  if [[ ! $USER_GUESS =~ ^[0-9]*$ ]]
  then
    GUESS "That is not an integer, guess again:"
  fi

  GUESS_COUNT=$(( GUESS_COUNT + 1 ))

  if (( $USER_GUESS < $RANDOM_NUMBER ))
  then
    GUESS "It's higher than that, guess again:"
  elif (( $USER_GUESS > $RANDOM_NUMBER ))
  then
    GUESS "It's lower than that, guess again:"
  elif (( $USER_GUESS == $RANDOM_NUMBER ))
  then
    RECORD_GAME
  fi
  echo -e "\nSomething went wrong while guessing!"
}

RECORD_GAME() {
    
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(game_guesses, user_id) VALUES($GUESS_COUNT, $USER_ID)")
  if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
  then
    echo -e "\nYou guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
    exit
  fi
  echo -e "\nSomething went wrong while registering a game record!"
}

WELCOME_MENU
