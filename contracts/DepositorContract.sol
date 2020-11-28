// SPDX-License-Identifier: MIt
pragma solidity >=0.4.22 <0.8.0;
import "./ERC20TD.sol";
import "./DepositorToken.sol";

contract DepositorContract {
    uint256 public totalSupply = 0;
    address private contractAddr;
    address private contractAddrTkn;
    mapping(address => uint256) public claimers;

    constructor(address _contractAddr, address _contractAddrTkn) public {
        contractAddr = _contractAddr;
        contractAddrTkn = _contractAddrTkn;
    }

    function claimTokensFromTeacher() public {
        ERC20TD(contractAddr).claimTokens();
        claimers[msg.sender] += 1000;
        totalSupply += 1000;
    }

    // @withdrawTokens(uint256 amount)
    function withdrawTokens(uint256 amount) public {
        require(claimers[msg.sender] > 0, "You need to claim some tokens");
        require(amount <= claimers[msg.sender], "Not enough tokens");
        DepositorToken(contractAddrTkn).burn(msg.sender, amount);
        ERC20TD(contractAddr).transfer(msg.sender, amount);
        claimers[msg.sender] -= amount;
        totalSupply -= amount;
    }

    // @depositTokens(uint256 amount)
    // You need to approve DepositorContract with your user account before being allowed to deposit your tokens
    // See TD-ERC20 contract ->  https://rinkeby.etherscan.io/address/0x58e9b79f804ebd4a3109068e1be414d0baac18ec#writeContract
    function depositTokens(uint256 amount) public {
        require(amount > 0, "You need to deposit some tokens");
        DepositorToken(contractAddrTkn).mint(msg.sender, amount);
        ERC20TD(contractAddr).transferFrom(msg.sender, address(this), amount);
        claimers[msg.sender] += amount;
        totalSupply += amount;
    }
}

// function withdrawTokens(uint256 amount) public {
//     require(claimers[msg.sender] > 0, "You need to claim some tokens");
//     require(amount <= claimers[msg.sender], "Not enough tokens");
//     ERC20TD(contractAddr).transfer(msg.sender, amount);
//     claimers[msg.sender] -= amount;
//     totalSupply -= amount;
// }

// function depositTokens(uint256 amount) public {
//     require(amount > 0, "You need to deposit some tokens");
//     ERC20TD(contractAddr).transferFrom(msg.sender, address(this), amount);
//     claimers[msg.sender] += amount;
//     totalSupply += amount;
// }
