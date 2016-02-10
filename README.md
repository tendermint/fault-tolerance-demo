# fault-tolerance-demo
A demo of tendermint's fault tolerance. 

Start a testnet with four nodes, monitor it to ensure it's healthy (making blocks).
Kill a node, the network should remain healthy. Kill a second node, the network should cease making blocks.
Bring a stopped node back online and the network should continue making blocks.

Pre-requisites

- Install tendermint, mintnet (ports branch), tmsp dummy, tmsp-cli, netmon
- Launch machines test1, test2, test3, test4
- jq for pretty printing json


Scripts

- `launch.sh` - launch the testnet on the machines and start the netmon to monitor them
- `rm.sh` - remove the testnet and all created files. inverse of launch.sh
- `start_mint.sh` - start a local tendermint node that syncs with the testnet. acts as a proxy for transactions
- `send_tx.sh` - send thousands of random transactions to the local node to broadcast to the network


Commands

- `curl -s http://localhost:46670/get_chain?chainID=\"mynewchain\" | jq .` - monitor the health and current state of the chain
- `curl -s http://localhost:46657/unconfirmed_txs | jq .` - see the txs in the mempool
- `curl -s http://localhost:46657/unconfirmed_txs | jq .result[1].n_txs` - size of the mempool
- `mintnet rm --force --machines "test1" mynewapp` - kill a node
- `mintnet start --machines "test1" --seed-machines "test[1-4]" mynewapp mynewchain` - start a node

Notes

Send transactions with

```
curl http://localhost:46657/broadcast_tx_sync?tx=\"$(toHex foo=bar)\"
```

where `toHex` is the bash function

```
function toHex() {
	echo -n $1 | hexdump -ve '1/1 "%.2X"'
}
```

And query for the result with

```
tmsp-cli query foo
```

which should, in this case, return `bar`
