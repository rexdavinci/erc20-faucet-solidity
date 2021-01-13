// SPDX-License-Identifier: MIT
// pragma solidity 0.5.16;
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20Token is ERC20, Ownable {
  using SafeMath for uint256;

  mapping (address => uint256) private _balances;

  mapping (address => mapping (address => uint256)) private _allowances;

  uint256 private _totalSupply;
  uint8 private _decimals;
  string private _symbol;
  string private _name;

  constructor() public ERC20 ("ERC20 Token", "ERC"){
    _mint(msg.sender, 1000000000 * 10 ** 18);
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  function getOwner() external view returns (address) {
    return owner();
  }
}