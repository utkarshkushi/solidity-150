# solidity-150
I will be solving 150 blockchain and solidity based questions 

## Question-1 
Write a Solidity function to check if a given address is a contract or not.
- There are two types of addresses EOA(Externally Owned Address - controlled by private address i,e has been develped using seed phrase) and CA(Contract Address - which belongs to a smart contract). To know if a address is contract owned we take help of EVM assembly langauge to get information about the code size (using extcodesize).
If the size is greater than 0, then it is contract address.

## Question-2
Write a Solidity function to transfer tokens from one address to another.
- Here i have used IERC20 token interface and tranferFrom function to transer the eth. The constructor requires us to provide an address who will own the IERC20 tokens an this address is used to create the instance. Then we'll transfer the amount of tokens.

## Question-3
Write a Solidity function to withdraw funds from a smart contract.
- This contract also needs an deposit function which is payable and accepts eth when called. The record of the caller and sent amount is stored in a public addess.
The withdraw function tranfers the amount the address has stored with the contract whose deposited amount will be known by the public mapping. The amount is transferred using transfer function.

## Question-4
Write a Solidity function to check the balance of a given address.
- I have just added a view knowBalance function to the previous code.


## Question-5
Write a Solidity function to implement a voting system, where each address can vote only once.
- Here addresses can caste their vote either to A or B, which as index is sent when casteVote is called. Mapping is used to know the voting status (True - casted vote, False - not yet casted). Once voted the vote status is updated. 

## Question-6
Write a Solidity function to implement a time-locked contract, which allows funds to be withdrawn only after a certain time has elapsed.
- Time in solidity is found by block.timestamp function which is unix epoch based, time in solidity is measuerd in seconds and days, weeks, years corresponds to its number of seconds. 

## Question-7
Write a Solidity function to implement a basic ERC-20 token.
- Here i am importing ERC20 token from open Zeppeliin and inheriting ERC20 into the contract, defined an constructor and also ERC20 constructor taking name and symbol of the token. The constructor invokes teh _mint() function transfering 10 tokens to the address deploying the contract. 

## Question-8
write a Solidity contract where users can send ETH and buy ERC20 tokens
- The code here is extension of the above solution. Here the _mint() is not called in the constructor but s called by a function buyTokens(). we set the price of tokens, you get 10 tokens for 1 ETH.

## Question-9
write a smart contract implementing multi signature wallet, that requires a bunch of addresses to sign the transaction before it is executed
- multi signing of transaction is used to secure the transaction being made on the funds which is owned by multiple people and also it is done to secure the transaction. Here I have decalred a array of owners and noOfVotes variable to decide the number of votes required to su=ign the transaction.

## Question-10
write a smart contract implementing staking system, where the user will be rewrded with some pecent of interest for staking his tokens
- in this contract, when a address delpoys the erc20 token contract he gets 1/2 of the capped supply to himself which he can use to reward to people when they stake their tokens. When the user completes the staking period he will be rewarded extra tokens 
