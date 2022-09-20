#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    GET_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  else
    GET_ELEMENT=$($PSQL "SELECT name FROM elements WHERE symbol='$1' OR name='$1'")
  fi
  if [[ -z $GET_ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
        ELEMENT=$(echo $GET_ELEMENT | sed 's/ |/"/')
    GET_AN=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT'")
    ATOMIC_NUMBER=$(echo $GET_AN | sed 's/ |/"/')
    GET_SYMB=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$GET_AN")
    SYMBOL=$(echo $GET_SYMB | sed 's/ |/"/')
    GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id=properties.type_id WHERE atomic_number=$GET_AN")
    TYPE=$(echo $GET_TYPE | sed 's/ |/"/')
    GET_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$GET_AN")
    MASS=$(echo $GET_MASS | sed 's/ |/"/')
    GET_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$GET_AN")
    MELT=$(echo $GET_MELT | sed 's/ |/"/')
    GET_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$GET_AN")
    BOIL=$(echo $GET_BOIL | sed 's/ |/"/')
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ELEMENT has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
fi
