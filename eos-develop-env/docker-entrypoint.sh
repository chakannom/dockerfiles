#!/bin/bash

EOSIO_HOME=/home/eosio

# setup term handler
# SIGTERM-handler
term_handler() {

  sleep 1

  exit 143; # 128 + 15 -- SIGTERM
}
trap 'kill ${!}; term_handler' SIGTERM

# run application

sleep 1

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

