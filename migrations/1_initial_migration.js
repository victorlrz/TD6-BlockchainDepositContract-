const DepositorContract = artifacts.require("DepositorContract");
const DepositorToken = artifacts.require("DepositorToken");

module.exports = function (deployer) {
  deployer.deploy(DepositorToken,"0x58e9b79f804ebd4a3109068e1be414d0baac18ec").then(function(){
    return deployer.deploy(DepositorContract, "0x58e9b79f804ebd4a3109068e1be414d0baac18ec", DepositorToken.address)
  });
};















