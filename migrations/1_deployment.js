const ERC20 = artifacts.require("ERC20Token");
const Faucet = artifacts.require("Faucet");
const FaucetPaymaster = artifacts.require("FaucetPaymaster");

const erc20TokenAddress = '0x0566300f84f410040Ab9CF22B311A1261d494564'
const trustedForwarderAddress = '0xd9c1a99e9263B98F3f633a9f1A201FA0AFC2A1c2' // goerli
const relayHubAddress = '0x1F3d1C33977957EA41bEdFDcBf7fF64Fd3A3985e' //goerli network

module.exports = async function(deployer, network, accounts) {
  const owner = accounts[0];

  // await deployer.deploy(FaucetPaymaster)
  // const faucetPaymaster = await FaucetPaymaster.deployed()

  // await faucetPaymaster.setRelayHub(relayHubAddress)

  // await faucetPaymaster.setTrustedForwarder(trustedForwarderAddress)

  // await deployer.deploy(ERC20)
  // const erc20 = await ERC20.deployed()

  await deployer.deploy(Faucet, trustedForwarderAddress, erc20TokenAddress)

  const faucet = await Faucet.deployed()
  

  // await faucetPaymaster.setTarget(faucet.address)

  // web3.eth.sendTransaction({ from: owner, to: faucetPaymaster.address, value: 1e18 }) // Send 1 ether to paymaster contract

  // console.log({ faucetPaymaster: faucetPaymaster.address, targetedFaucet: faucet.address, owner, erc20TokenAddress })

  // if(network === 'develop') {
  //   await deployer.deploy(Dai);
  //   const dai = await Dai.deployed();
  //   console.log(dai.address)
  //   await dai.faucet(payer, web3.utils.toWei('10000'));

  //   await deployer.deploy(PaymentProcessor, admin, dai.address);

  // } else {
  //   const ADMIN_ADDRESS = '';
  //   const DAI_ADDRESS = '';
  //   await deployer.deploy(PaymentProcessor, ADMIN_ADDRESS, DAI_ADDRESS);
  // }
};