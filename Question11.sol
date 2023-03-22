//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";



contract BlindAuction{
    
    address[] public pastWinners;

    uint public amountToEnter = 1 ether;

    address[] public bidders;

    address public owner;

    mapping(address=>uint) public amountBid;

    constructor(){
        owner = msg.sender;
    }

    function makeBid() public payable{
        require(msg.sender != owner, "owner cannot bid");
        require(msg.value >= 0, "send some eth");
        bidders.push(msg.sender);
        amountBid[msg.sender] = msg.value;
    }

    function chooseWinner() public returns(address){
        require(msg.sender == owner, "only owner can call");
        uint256 highestBid;
        address currentWinner;
        for(uint i=0; i<bidders.length; i++){
            if(amountBid[bidders[i]] > highestBid){
                highestBid = amountBid[bidders[i]];
                currentWinner = bidders[i];
            }
        }

        for(uint i=0; i<bidders.length; i++){
            if(bidders[i] != currentWinner){
                payable(bidders[i]).transfer(amountBid[bidders[i]]);
            }
            amountBid[bidders[i]] = 0;
        }
        pastWinners.push(currentWinner);
        delete bidders;

        return currentWinner;

    }

    



}
