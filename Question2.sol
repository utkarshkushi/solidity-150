SPDX-License-Identifier: MIT




pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract TokenTransfer {
    address private _tokenAddress;

    constructor(address tokenAddress) {
        _tokenAddress = tokenAddress;
    }

    function transferTokens(address from, address to, uint256 amount) public {
        IERC20 token = IERC20(_tokenAddress);
        require(token.transferFrom(from, to, amount), "Transfer failed");
    }
}
