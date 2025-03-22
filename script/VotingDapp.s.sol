// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/token.sol";
import{VoteDApp} from "../src/VotingDapp.sol";

contract VoteDappScript is Script{
    function runToken(uint256 initialSupply)external returns (Token){
        vm.startBroadcast();
        Token token = new Token(initialSupply);
        vm.stopBroadcast();

        return token;
    }

    function RunVoteDapp(address tokenaddress)external returns(VoteDApp){
        vm.startBroadcast();
        VoteDApp votedapp=new VoteDApp(tokenaddress);
        vm.stopBroadcast();

        return votedapp;
    }
}