const Web3 = require('web3');

const web3 = new Web3('HTTP://127.0.0.1:7545')

web3.eth.getAccounts()
    .then(console.log);
web3.eth.getBalance('0xE188d4d0DDCA8C2074Af5669956B0005aaa96420')
    .then(console.log);

