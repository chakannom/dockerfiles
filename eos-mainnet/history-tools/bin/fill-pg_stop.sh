#!/bin/bash

EOSIO_HOME=/home/eosio
HISTORY_TOOLS_HOME=${EOSIO_HOME}/history-tools

if [ -f "${HISTORY_TOOLS_HOME}/fill-pg.pid" ]; then
  pid=`cat "${HISTORY_TOOLS_HOME}/fill-pg.pid"`
  echo $pid
  kill $pid
  rm -r "${HISTORY_TOOLS_HOME}/fill-pg.pid"

  echo "Stoping fill-pg..."

  while true; do
    if [ ! -d "/proc/$pid/fd" ]; then
      break;
    fi

    echo "."

    sleep 1
  done

  echo "Stopped fill-pg!!"
fi
