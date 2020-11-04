#!/bin/bash

EOSIO_HOME=/home/eosio
NODE_HOME=${EOSIO_HOME}/node

if [ ! -d ${NODE_HOME}/logs ]; then
  mkdir ${NODE_HOME}/logs
fi

${EOSIO_HOME}/eos/2.0/bin/nodeos \
 -e \
 --agent-name "EOS Mainnet Node" \
 --data-dir ${NODE_HOME}/data \
 --config-dir ${NODE_HOME}/config \
 --disable-replay-opts \
 --replay-blockchain \
 --genesis-json ${NODE_HOME}/config/genesis.json \
>> ${NODE_HOME}/logs/nodeos.log 2>&1 &

echo $! > ${NODE_HOME}/nodeos.pid

echo "Started node!!( ${NODE_HOME} )"

