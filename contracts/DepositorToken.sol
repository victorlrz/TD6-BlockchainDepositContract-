// SPDX-License-Identifier: MIt
pragma solidity >=0.4.22 <0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC20TD.sol";

contract DepositorToken is ERC20 {
    address private contractAddr;

    constructor(address _contractAddr) public ERC20("TokenEx", "TKNX") {
        contractAddr = _contractAddr;
    }

    modifier checkAuthorization(address account, uint256 amount) {
        require(
            ERC20TD(contractAddr).allowance(account, msg.sender) >= amount,
            "Not allowed"
        );
        _;
    }

    function mint(address account, uint256 amount)
        public
        checkAuthorization(account, amount)
    {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }
}
