//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";



contract stakingSystem is ERC20Capped{
    
    address public owner; 

    uint public TokensPerETH = 2; 

    uint public StakingPeriod = 12 weeks;

    uint public stakingInterestPercent = 32; 

 
    constructor(uint cap) ERC20("StakingTokens", "STK") ERC20Capped(cap) {
        owner = msg.sender;
        
        _mint(owner,cap/2);
    }

    struct StakingDetails{
        address who;
        uint amtOfTokens;
        uint StakingStartTime;
        uint StakingEndTime;
        bool claimed;
    }

    mapping(address => bool) public alreadyStaked; 
    mapping(address => uint) public indexOfStakedDetails;

    StakingDetails[] public stakingDetails;
 
    function buyTokens() public payable {
        require(msg.value>0, "send eth");
        _mint(msg.sender, msg.value * TokensPerETH);
        
    }

    function StakeTokens(uint stakingAmt) public {
        require(!(msg.sender == owner), "owner cannot call staking function");
        require(balanceOf(msg.sender) >= stakingAmt, "no enough funds");
        require(!alreadyStaked[msg.sender], "you have already staked");
        transfer(owner, stakingAmt);
        alreadyStaked[msg.sender] = true;
        uint stakedTime = block.timestamp;
        stakingDetails.push(StakingDetails({who: msg.sender, amtOfTokens: stakingAmt, StakingStartTime: stakedTime, StakingEndTime: stakedTime+StakingPeriod, claimed: false}));
        indexOfStakedDetails[msg.sender] = stakingDetails.length - 1;

    }

    function ClaimStakedTokens() public returns(uint){
        require(alreadyStaked[msg.sender], "you have not staked any tokens yet");
        require(block.timestamp > stakingDetails[indexOfStakedDetails[msg.sender]].StakingEndTime, "your staking period is not over");
        // uint amount = (stakingDetails[indexOfStakedDetails[msg.sender]].amtOfTokens * (stakingInterestPercent / 100)) +  stakingDetails[indexOfStakedDetails[msg.sender]].amtOfTokens;
        uint amount = stakingDetails[indexOfStakedDetails[msg.sender]].amtOfTokens * stakingInterestPercent / 100 + stakingDetails[indexOfStakedDetails[msg.sender]].amtOfTokens;
        _transfer(owner,msg.sender,amount);
        stakingDetails[indexOfStakedDetails[msg.sender]].claimed = true;
        alreadyStaked[msg.sender] = false;
        return amount;
    }

}
