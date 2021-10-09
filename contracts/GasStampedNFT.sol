//SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GasStampedNFT is ERC721 {
    uint minGasPrice; // in gwei
    uint maxGasPrice; // in gwei
    uint mintsPerGasLevel;
    uint maxSupply;
    uint costPerToken; // in gwei
    uint maxMinerTip; // as percentage of tx.gasprice
    uint counter = 0;
    uint public mintTimestamp;

    mapping(uint => uint) public mintsByLevel;

    constructor(uint _minGasPrice, uint _maxGasPrice, uint _mintsPerGasLevel, 
        uint _costPerToken, uint _minersTipLimit, uint _mintTimestamp)
        ERC721("GasStampedNFT", "GSN") {
            minGasPrice = _minGasPrice;
            maxGasPrice = _maxGasPrice;
            mintsPerGasLevel = _mintsPerGasLevel;
            maxSupply = (maxGasPrice - minGasPrice + 1) * mintsPerGasLevel;
            maxMinerTip = _minersTipLimit;
            costPerToken = _costPerToken;
            mintTimestamp = _mintTimestamp;
        }
    
    function mint(address _to) payable public {
        // Check if mint is live
        require(block.timestamp > mintTimestamp, "Mint not live");
        require(counter < maxSupply, "All sold out");

        // Check if mint request is valid
        require(msg.value >= costPerToken * 1e9, "Invalid payment");

        // Check if gas level is valid
        uint gasLevel = tx.gasprice / 1e9; // gas price in gwei
        require((gasLevel >= minGasPrice && gasLevel <= maxGasPrice), "Gas price out-of-range");
        require(mintsByLevel[gasLevel] < mintsPerGasLevel, "Mint limit reached for this gas level");

        // Check for miner tip percentage
        uint minerTip = ((tx.gasprice - block.basefee) * 100) / tx.gasprice;
        require(minerTip < maxMinerTip, "Miner's tip too high");

        // Mint NFT
        _safeMint(_to, counter++);
        mintsByLevel[gasLevel]++;
    }
    
}