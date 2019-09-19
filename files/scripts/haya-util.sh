#!/usr/bin/env bash

ACC_NAME=$1
ACC_KEY_PUB=$2
ACC_AMOUNT=$3

function acc_create(){
haya-cli \
	--wallet-url=http://localhost:6666 \
	--url=http://localhost:8888 \
	system newaccount \
		-x 45 eosio \
		--transfer ${ACC_NAME} ${ACC_KEY_PUB} \
		--stake-net "10.0000 BET" \
		--stake-cpu "10.0000 BET" \
		--stake-vote "0.0000 BET" \
		--buy-ram-kbytes 8192
}

function transfer(){
haya-cli \
	--wallet-url=http://localhost:6666 \
	--url=http://localhost:8888 \
	transfer -j \
		eosio ${ACC_NAME} "${ACC_AMOUNT}"
}

#acc_create
transfer
