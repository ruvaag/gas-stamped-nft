const hre = require("hardhat");

async function main() {
  // Constructor arguments
  const minGasPrice = 50; // in gwei
  const maxGasPrice = 300; // in gwei
  const mintsPerGasLevel = 3;
  const costPerToken = 0.05 * 1e9; // in gwei
  const maxMinerTip = 30; // as percentage of tx.gasprice
  const mintTimestamp = 0
  
  const GasStampedNFT = await hre.ethers.getContractFactory("GasStampedNFT");
  const gasStampedNFT = await GasStampedNFT.deploy(minGasPrice, maxGasPrice, mintsPerGasLevel, 
    costPerToken, maxMinerTip, mintTimestamp);

  await gasStampedNFT.deployed();

  console.log("Contract successfully deployed to:", gasStampedNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
