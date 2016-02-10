#! /bin/bash

killall dummy
killall tendermint
rm -rf ~/.tendermint

tendermint init
cp mynewchain/test1/core/genesis.json ~/.tendermint/genesis.json
dummy &
tendermint node --seeds "$(docker-machine ip test1):46656,$(docker-machine ip test2):46656,$(docker-machine ip test3):46656,$(docker-machine ip test4):46656"
