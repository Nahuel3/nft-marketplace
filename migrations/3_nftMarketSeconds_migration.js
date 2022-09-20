const NftMarketSeconds = artifacts.require("NftMarketSeconds");

module.exports = function (deployer) {
  deployer.deploy(NftMarketSeconds);
};