//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TimeLocked{

    mapping(address => uint256) public deadlines;
    mapping(address => uint256) public savings;

    function deposit(uint256 _noOfDays) payable public returns(bool) {
        require(msg.value > 0, "send ETH");
        deadlines[msg.sender] = block.timestamp + (_noOfDays * 1 days) ;
        savings[msg.sender] = msg.value;
        return (true);
    }

    function withDraw() public{
        require(block.timestamp > deadlines[msg.sender], "Time has not elapsed");
        payable(msg.sender).transfer(savings[msg.sender]);
    }


}
