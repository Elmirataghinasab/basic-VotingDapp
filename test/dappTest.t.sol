// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import {Token} from "../src/token.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {VoteDApp} from "../src/VotingDapp.sol";
import {VoteDappScript} from "../script/VotingDapp.s.sol";


contract VoteDAppTest is Test{
    VoteDappScript deploy;
    Token token;
    VoteDApp votedapp;


    address user1=address(2);
    address user2=address(3);
    address user3=address(4);
    address user4=address(5);
    address user5=address(6);
    address Owner;
    uint256 initialSupply=100e18;
    uint256 decimal;

     function setUp()public{
        deploy= new VoteDappScript();
        token=deploy.runToken(initialSupply);
        votedapp=deploy.RunVoteDapp(address(token));
        Owner=votedapp.GetOwner();
        decimal=votedapp.GetDecimal();

    }


    function testparticipate()public{
        vm.startPrank(Owner);
        token.transfer(user1, 20*decimal);
        vm.stopPrank();

        vm.startPrank(user1); 
        token.approve(address(votedapp),20*decimal);          
        votedapp.participate(true);
        vm.stopPrank();

        assertEq(19,votedapp.getSupportVotes());
        assertEq(0,votedapp.getRejectionVotes());
        assertEq(votedapp.GetIfUserVoted(user1),true);
    }


    function testelection()public{
        vm.startPrank(Owner);
        token.transfer(user1, 20*decimal); 
        token.transfer(user2, 20*decimal);
        token.transfer(user3, 60*decimal);
        vm.stopPrank();

        vm.startPrank(user1); 
        token.approve(address(votedapp),20*decimal);          
        votedapp.participate(true);
        vm.stopPrank();
        vm.startPrank(user2); 
        token.approve(address(votedapp),20*decimal);          
        votedapp.participate(true);
        vm.stopPrank();
        vm.startPrank(user3); 
        token.approve(address(votedapp),60*decimal);          
        votedapp.participate(false);
        vm.stopPrank();

        vm.warp(block.timestamp + votedapp.getInitialTime() + votedapp.getDeadline());
        vm.startPrank(Owner);
        bool success=votedapp.election();
        vm.stopPrank();

        assertEq(false,success);
        assertEq(votedapp.GetWinner(),false);


    }
    function testParticipteReverts()public{

        vm.startPrank(Owner);
        token.transfer(user1, 10*decimal);
        vm.stopPrank();

        vm.startPrank(user1); 
        token.approve(address(votedapp),10*decimal);  
        vm.expectRevert();        
        votedapp.participate(true);
        vm.stopPrank();



        vm.startPrank(Owner);
        token.transfer(user1, 10*decimal);
        vm.stopPrank();
        vm.startPrank(user1); 
        token.approve(address(votedapp),20*decimal); 
        votedapp.participate(true); 
        vm.expectRevert();        
        votedapp.participate(true);
        vm.stopPrank();

    }

    function testElectionsRevert()public{

        vm.startPrank(Owner);
        vm.expectRevert();
        votedapp.election();
        vm.stopPrank();

    }

}