SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CallerChecker {
    function isContract() public view returns (bool) {
    uint size;
    address a = msg.sender;
    assembly { size := extcodesize(a) }
    return size > 0;
    }
}
