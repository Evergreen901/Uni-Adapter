pragma solidity >=0.6.0;
// SPDX-License-Identifier: UNLICENSED
import "lib/ds-note/note.sol";

interface IUniswapV2ERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
}

abstract contract VatLike {
    function slip(bytes32,address,int256) public virtual;
}

contract UniAdapter is DSNote {
    VatLike public vat;
    bytes32 ilkName = "Uni-Dai";
    IUniswapV2ERC20 public gem;

    constructor(address vat_, address gem_) public {
        vat = VatLike(vat_);
        gem = IUniswapV2ERC20(gem_);
    }

    function join(address urn, uint256 amt) external note {
        require(uint256(uint160(amt)) == amt, "amt-overflow");

        gem.transferFrom(msg.sender, address(this), amt);
        vat.slip(ilkName, urn,  1);
    }

    function exit(address usr, uint256 amt) external note {
        require(uint256(uint160(amt)) == amt, "amt-overflow");

        gem.transferFrom(address(this), usr, amt);
        vat.slip(ilkName, msg.sender, -1);
    }
}