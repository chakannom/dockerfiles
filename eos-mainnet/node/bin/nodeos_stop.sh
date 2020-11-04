#!/bin/bash

EOSIO_HOME=/home/eosio
NODE_HOME=${EOSIO_HOME}/node

if [ -f "${NODE_HOME}/nodeos.pid" ]; then
  pid=`cat "${NODE_HOME}/nodeos.pid"`
  echo $pid
  kill $pid
  rm -r "${NODE_HOME}/nodeos.pid"

  echo "Stopping Node..."

  while true; do
    if [ ! -d "/proc/$pid/fd" ]; then
      break;
    fi

    echo "."
    
    sleep 1
  done

  echo "Stopped Node!! ( ${NODE_HOME} )"
fi

