const adapter = artifacts.require("UniAdapter");
const Pip = artifacts.require('UniPip');

module.exports = async function (deployer) {
  const vatAddress = "0xbA987bDB501d131f766fEe8180Da5d81b34b69d9";
  const uniAddress = "0x92FacdfB69427CffC1395a7e424AeA91622035Fc";
  let deployAdapter = await deployer.deploy(adapter, vatAddress, uniAddress);
  deployer.deploy(Pip, adapter.address);
};
