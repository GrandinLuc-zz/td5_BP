const TotemToken = artifacts.require("TotemToken");

// Deploy to testnet
const data = require('../secret.json');

module.exports = function (deployer, network, accounts) {
  deployer.deploy(TotemToken, 10, 1000000, {from: data.address});
};
// var TotemToken = await TotemToken.deployed()