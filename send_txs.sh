#! /bin/bash


function toHex() {
	echo -n $1 | hexdump -ve '1/1 "%.2X"'
}

for i in `seq 1 10000`;
do
	randomKey="$(dd if=/dev/urandom bs=5 count=1)"
	randomVal="$(dd if=/dev/urandom bs=10 count=1)"
	curl http://localhost:46657/broadcast_tx_sync?tx=\"$(toHex ${randomKey}=${randomVal})\"
	#curl http://localhost:46657/broadcast_tx_sync?tx=\"abcd\"
	echo $(toHex $randomKey)
	sleep 0.1
done    
        


