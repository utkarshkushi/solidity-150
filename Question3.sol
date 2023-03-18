SPDX-License-Identifier: MIT



pragma solidity ^0.8.0;

contract TranserFunds{
    mapping(address => uint256 ) public balances;

    function deposit() payable public {
        require(msg.value > 0, "you have't sent any amount");
        balances[msg.sender] = msg.value;
    } 

    function withDraw() public {
        require(balances[msg.sender] != 0, "you don't have any balances");
        payable(msg.sender).transfer(balances[msg.sender]);
    }

}
