const SHA256 = require('crypto-js/sha256');
const TARGET_DIFFICULTY = BigInt(0x0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
const MAX_TRANSACTIONS = 10;

const mempool = [];
const blocks = [];

function addTransaction(transaction) {
    // TODO: add transaction to mempool
    mempool.push(transaction)
}

function mine() { 
    // TODO: mine a block
    const transactions = mempool.slice(0, MAX_TRANSACTIONS);

    let nonce = 0;

    let block = {
        id: blocks.length, 
        transactions,
        nonce
    }

    blocks.push(block);
    block.hash = SHA256(JSON.stringify(block));

    mempool.splice(0, MAX_TRANSACTIONS);
}

module.exports = {
    TARGET_DIFFICULTY,
    MAX_TRANSACTIONS,
    addTransaction, 
    mine, 
    blocks,
    mempool
};