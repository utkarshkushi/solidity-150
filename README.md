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

