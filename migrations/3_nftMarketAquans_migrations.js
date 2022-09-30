const NftMarketAquans = artifacts.require("NftMarketAquans");

module.exports = function (deployer) {
  deployer.deploy(NftMarketAquans);
};