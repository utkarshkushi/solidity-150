SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
 
contract VotingSystem{
    mapping(address => bool) voteStatus;
    uint256 public votesForA;
    uint256 public votesForB; 
    function castVote(uint32 index) public{
        require(voteStatus[msg.sender] == false, "you have already casted your vote");
        if(index == 0){
            votesForA++;
        }
        else{
            votesForB++;
        }
        voteStatus[msg.sender] = true;
    }
}
