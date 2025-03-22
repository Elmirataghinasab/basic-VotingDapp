// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";



contract Token is ERC20{

    constructor(uint256 initialSupply)ERC20("VOTETOKEN", "VT") {

        _mint(msg.sender, initialSupply);

    }
    
}