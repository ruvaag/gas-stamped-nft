# Gas Stamped NFTs
#### Another FCFS NFT Mint Mechanism

### The Problem
A moderately hyped NFT drop on ETH L1 can see gas prices skyrocket to upto four digit gwei levels. 
And what's the problem here? Obviously, you're paying ~25-50x of what you'd pay for a typical 
transaction. Moreover, this gas premium creates an inherent inequity favoring richer accounts, 
simply because they can afford to pay for the gas.

Secondly, there's another problem that isn't reflected in gas prices, but in the buyers themselves. 
Based on web3 familiarity, there are three kinds of NFT buyers — humans, humans who can use etherscan 
and bots. With humans (both who can and cannot use Etherscan), the drop turns into a fastest finger 
first competition with all everyone eventually at the mercy of the network-latency gods.

### So WTF is a Gas-Stamped Mint
Gas-stamped mints provide a fun way to mitigate these problems. They also create a relatively fairer
(level playing field) for all human actors that are part of the mint. Gas-stamping a transaction 
binds it to the gas price paid for the transaction using the `tx.gasprice` global variable. 
Post-EIP1559, this gas price is the (Base Fee + Priority Fee). The Miner's tip can be accessed in 
the contract via `tx.gasprice - block.basefee`. 

### What does a Gas Stamped Mint Look Like
- Ranged Mint Transactions
    - The contract can limit the range of gas prices between which NFTs are minted to create a level
    playing field - e.g NFTs can only be minted between 50-150 gwei.
    - This can also be coupled with rarity features - rarer pieces can only be minted at a higher gas price.
    - Arbitrary gas price mints can have special value - e.g. a 420 gwei mint transaction allows you 
    to mint a *highly* sought-after NFT
- Gas Caps
    - Different gas level transactions can mint a different number of pieces
    - This could be used to create a mint process where the mints are skewed towards lower gas levels
    i.e most mints are at low levels while some are at higher levels
- Creator-centric
    - This is good for creators too because now NFT themselves can be priced higher i.e. it'd be 
    reasonable to pay 0.05E (instead of 0.01E) for the same mint when you know that you're never 
    gonna pay outrageous gas fees on top.

### Downsides
- Mints could stretch for hours depending on network usage, this might not be ideal
- Long mints could create an artificial asymmetery on secondary market platforms, i.e. those who 
mint earlier stand to gain more
- Mints still need bot protection and the whole process is vulnerable to OTC bribes accepted by
miners
