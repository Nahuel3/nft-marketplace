const HDWalletProvider = require("@truffle/hdwallet-provider");

const apikeys = require("./chains/apikeys");
const keys = require("./keys.json");

module.exports = { 
  
  plugins: ["truffle-plugin-verify"],
  api_keys:{
    etherscan: "1RSBK6J5EHHVYTFXWTJMCDRRT3553FNWP8"
  },
  contracts_build_directory: "./public/contracts",
  networks: {
    
     development: {
      host: "127.0.0.1",    
      port: 7545,            
     network_id: "*",     
     },
    sepolia: {
      provider: () => 
      new HDWalletProvider(
        keys.PRIVATE_KEY,
        keys.INFURA_SEPOLIA_URL,       
      ),
      network_id: 11155111,
      chain_id: 11155111,
      gas:5221975,
      gasPrice:20000000000,
      confirmations: 3,
      timeoutBlocks:200,
      skipDryRun: true
    }
  },

  compilers: {
    solc: {
      version: "0.8.16",
      settings: {
        optimizer: {
        enabled: true, // Default: false
        runs: 1000 // Default: 200
        }
        }       
    }
  },

 
};
