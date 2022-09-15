#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Welcome to My Salon, how can I help you?" 
  SERVICES_LIST=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES_LIST" | while read SERVICE_ID_SELECTED BAR NAME
    do
      echo "$SERVICE_ID_SELECTED) $NAME"
    done
  read MAIN_MENU_SELECTION
  CHECK_EXISTENCE=$($PSQL "SELECT name FROM services WHERE service_id=$MAIN_MENU_SELECTION")
  if [[ -z $CHECK_EXISTENCE ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else SERVICE $CHECK_EXISTENCE
  fi
}

SERVICE(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CHECK_PHONE=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CHECK_PHONE ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')") 
  fi  
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo -e "\nWhat time would you like your $1,$CUSTOMER_NAME?"
  read SERVICE_TIME
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE name='$1'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME')") 
  echo -e "\nI have put you down for a $1 at $SERVICE_TIME,$CUSTOMER_NAME."
}
EXIT() {
  echo -e "\nThank you for stopping in.\n"
}
MAIN_MENU
