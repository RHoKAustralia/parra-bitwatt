#!/bin/bash
echo "Starting private network"
geth --rpc --rpcaddr "0.0.0.0" \
	--gasprice 10000 \
	--datadir . \
	--genesis genesis.json \
	--networkid 10742 \
	--rpccorsdomain "*" \
	--mine --minerthreads "4" \
	--etherbase "0" \
	--rpcapi "db,eth,net,web3,personal" \
	--ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
	--nodiscover --maxpeers 0 \
	--ipcdisable \
	--unlock 0x3e0d0e42ce28b5ae471dfc4ade385a4bf39dc8a9 \
	--password passwordfile \
	console
