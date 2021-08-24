const Migrations = artifacts.require("ASSGNMT_ERC20");

module.exports = async function (deployer,networks,accounts) {
 await deployer.deploy(Migrations);
};
