#! /bin/bash

# deploy a testnet
mintnet init --machines "test[1-4]" chain --app dummy_init.sh mynewchain
mintnet start --machines "test[1-4]" mynewapp mynewchain

# massage the config file
echo "{}" > mon.json
netmon chains-and-vals chain mon.json mynewchain

# start the netmon
netmon monitor mon.json

