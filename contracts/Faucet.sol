// SPDX-License-Identifier:MIT

pragma solidity ^0.6.0 <0.8.0;

import "@opengsn/gsn/contracts/BaseRelayRecipient.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Faucet is BaseRelayRecipient {
    
  mapping(address => bool) private collected;
    
	event Droplet(address receiver, string token);
    event Transfer(address indexed sender, address indexed receiver, uint256 amount);
    
    address public tokenAddress;
    address public _owner;
    uint256 public freeEth;
    uint256 public droplet;

		ERC20 token;

    constructor(address forwarder, address _tokenAddress) public {
		trustedForwarder = forwarder;
		tokenAddress = _tokenAddress;
		_owner = _msgSender();
		token = ERC20(_tokenAddress);
	}
	
	receive() external payable { }
	
	function versionRecipient() override view external returns(string memory) {
	    return "2.0.3";
	}
	
	function changeOwnership(address owner) external onlyOwner {
	    _owner = owner;
	}
	
	function setDropletAmount(uint256 amount) external onlyOwner{
	    droplet = 1 ether * amount;
	}
	
	function setFreeEtht(uint256 amount) external richFaucet {
	    freeEth = 1 ether * amount;
	}
	
	function dropTo(address receiver) external {
		require(!collected[receiver], 'This address has received a drop before');
		collected[receiver] = true;
		require((droplet > 0) && (token.balanceOf(address(this))) >= droplet, 'Too dry to make a drop! Contact developer');
		token.transfer(receiver, droplet);
		if((freeEth > 0) && (address(this).balance >= freeEth)) {
		    payable(receiver).transfer(freeEth);
		}
	}
	
	function removeETH() external onlyOwner {
	    freeEth = 0;
	    payable(_owner).transfer(address(this).balance);
	}
	
	function removeTokens() external onlyOwner {
	   droplet = 0;
	   token.transfer(_owner, token.balanceOf(address(this))); 
	}
	
	modifier onlyOwner {
	    require(_msgSender() == _owner, 'Only the owner can perform that operation');
	    _;
	}
	
	modifier richFaucet {
	    require(_msgSender() == _owner, 'Only the owner can perform that operation');
	    require(address(this).balance > 0, 'Faucet is currently empty, Add some ETH and try again');
	    _;
	}
}