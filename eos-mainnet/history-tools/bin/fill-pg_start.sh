#!/bin/bash

EOSIO_HOME=/home/eosio
HISTORY_TOOLS_HOME=${EOSIO_HOME}/history-tools
STATE_HISTORY_ENDPOINT=127.0.0.1:8080

if [ ! -d ${HISTORY_TOOLS_HOME}/logs ]; then
  mkdir ${HISTORY_TOOLS_HOME}/logs
fi

export PGUSER=eospsql
export PGPASSWORD=eospsql
export PGDATABASE=eospsql
#export PGHOST=127.0.0.1:5432
export PGHOSTADDR=127.0.0.1
export PGPORT=5432

if [[ $1 == "init" ]]; then
  ${EOSIO_HOME}/eos/2.0/bin/fill-pg \
   --fpg-drop \
   --fpg-create \
   --fill-connect-to ${STATE_HISTORY_ENDPOINT} \
   --pg-schema chain \
  >> ${HISTORY_TOOLS_HOME}/logs/log.txt 2>&1 &  
else
  ${EOSIO_HOME}/eos/2.0/bin/fill-pg \
   --fill-connect-to ${STATE_HISTORY_ENDPOINT} \
   --pg-schema chain \
  >> ${HISTORY_TOOLS_HOME}/logs/log.txt 2>&1 &
fi

echo $! > ${HISTORY_TOOLS_HOME}/fill-pg.pid

echo "Started fill-pg!!"
