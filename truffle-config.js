var HDWalletProvider = require("truffle-hdwallet-provider");
const secret = require('./secret.json')

module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "dev"
     },
     rinkeby: {
         provider: function() { 
          return new HDWalletProvider(secret.mnemonic, `https://rinkeby.infura.io/v3/` + secret.projectId, 1);
         },
         network_id: 4,
         gas: 100000,
         gasPrice: 100000000,
     }
  },
  compilers: {
    solc: {
      version: "0.6.0",
      
    }
  },
  db: {
    enabled: false
  }
};
