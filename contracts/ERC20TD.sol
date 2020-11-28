// SPDX-License-Identifier: MIt
pragma solidity >=0.4.22 <0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20TD is ERC20 {
    constructor(uint256 initialSupply) public ERC20("TD-ERC20", "TDE") {
        _mint(msg.sender, initialSupply);
    }

    function claimTokens() public {
        _mint(msg.sender, 1000);
    }
}
