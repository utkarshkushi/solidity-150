//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract ExampleToken is ERC20{

    constructor() ERC20("ExampleTokens", "EXt") {
        
    }

    uint256 public TokenPerEth = 10;

    function buyTokens() public payable {
        require(msg.value > 0, "send enough eth");
        _mint(msg.sender, msg.value * 10 * 10**18);
    }


}
