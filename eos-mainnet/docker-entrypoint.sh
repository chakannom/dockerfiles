#!/bin/bash

EOSIO_HOME=/home/eosio

# setup term handler
# SIGTERM-handler
term_handler() {
  ## history-tools
  if [[ ${ENABLE_HISTORY_TOOLS} == true ]]; then
    ### fill-pg
    ${EOSIO_HOME}/history-tools/bin/fill-pg_stop.sh
    sleep 1
    ### postgresql
    service postgresql stop
    sleep 1
  fi
  ## node
  ${EOSIO_HOME}/node/bin/nodeos_stop.sh
  sleep 1

  exit 143; # 128 + 15 -- SIGTERM
}
trap 'kill ${!}; term_handler' SIGTERM

# run application
## node
${EOSIO_HOME}/node/bin/nodeos_start.sh
sleep 1
## history-tools
if [[ ${ENABLE_HISTORY_TOOLS} == true ]]; then
  ### posstgresql
  service postgresql start
  sleep 1
  ### fill-pg
  STR_EXISTS=$(PGPASSWORD=eospsql psql -tA -h 127.0.0.1 -p 5432 -U eospsql -w -c "SELECT  EXISTS (SELECT FROM pg_catalog.pg_tables WHERE schemaname = 'chain' AND tablename = 'account')")

  if [[ ${STR_EXISTS} == 'f' ]]; then
    ${EOSIO_HOME}/history-tools/bin/fill-pg_start.sh init
  else
    ${EOSIO_HOME}/history-tools/bin/fill-pg_start.sh
  fi
  sleep 1
fi

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

