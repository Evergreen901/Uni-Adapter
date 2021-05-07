pragma solidity >=0.6.0;

// SPDX-License-Identifier: UNLICENSED

import "lib/ds-thing/thing.sol";
import "lib/ds-value/value.sol";
import "./PriceConsumer.sol";

contract UniPip is DSThing, PriceConsumer{
    address immutable join;
    constructor(address join_) public {
        join = join_;
    }
    function peek() public returns (bytes32, bool) {
        uint256 price = uint256(getThePrice());
        return (bytes32(price), true);
    }
    function read() public returns (bytes32) {
        bytes32 wut; bool haz;
        (wut, haz) = peek();
        require(haz, "haz-not");
        return wut;
    }
}