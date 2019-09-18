#!/usr/bin/env bash

ACC_NAME="producer.1eb"
ACC_KEY_PUB="EOS8i5eZ4AZULRQXxBgAfV6vqo6LQctx7DGe1YT3FkcBDYdFNdy2w"
ACC_AMOUNT="10.0000 BET"

function acc_create(){
haya-cli \
	--wallet-url=http://localhost:6666 \
	--url=http://localhost:8888 \
	system newaccount \
		-x 45 eosio \
		--transfer ${ACC_NAME} ${ACC_KEY_PUB} \
		--stake-net "10.0000 BET" \
		--stake-cpu "10.0000 BET" \
		--stake-vote "1000000.0000 BET" \
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
