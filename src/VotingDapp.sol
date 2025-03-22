// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


/////imports/////
import {Token} from "./token.sol";

///interaces////
interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}


contract VoteDApp {

    ///errors/// 
    error VoteDApp_YouShouldHoldMoreVT();
    error VoteDApp_YouHaveVotedBefore();
    error VoteDApp_ParticipateFailed();
    error VoteDApp_TheProposalIsStillGoingOn();
    error VoteDApp_TheVotesAreEqualTryProposalAgain();
    error VoteDApp_OnlyOwnerCanCallThisFunction();


    ///events/// 
    event userVoted(address indexed user,bool indexed vote);
    event ProposalEnded();


    ///variables///
    uint256 private SupportVotes=0;
    uint256 private rejectionVotes=0;
    bool  private WINNER;
    uint256 constant private DECIMALS=10**18;
    address immutable OWNER;
    uint256 constant private DEADLINE=2592000; //deadLine is 1 month
    uint256 immutable INITIALTIME;

    ///arrays///
    mapping (address => bool) IfUserVoted;


    IERC20 public immutable VT;

    constructor(address votetoken){

        OWNER=msg.sender;
        VT= IERC20(votetoken);
        INITIALTIME = block.timestamp;

    }
    modifier onlyOwner {
        if (msg.sender != OWNER){
            revert VoteDApp_OnlyOwnerCanCallThisFunction();
        }
        _;
    }
    function participate(bool Vote)public{

        if(IfUserVoted[msg.sender] == true){
            revert VoteDApp_YouHaveVotedBefore();
        }

        bool success=VT.transferFrom(msg.sender,address(this),1*DECIMALS);
        if(!success){
            revert VoteDApp_ParticipateFailed();
        }

        uint256 PowerOfUser=VT.balanceOf(msg.sender)/DECIMALS;

        if(PowerOfUser < 10){
            revert VoteDApp_YouShouldHoldMoreVT();
        }

        if(Vote == true){
            SupportVotes+=PowerOfUser;
        }else if(Vote ==false){
            rejectionVotes+=PowerOfUser;
        }
        IfUserVoted[msg.sender]=true;

        emit userVoted(msg.sender,Vote);
    }
    function election()public onlyOwner returns (bool){
        if (block.timestamp < INITIALTIME+DEADLINE){
                revert VoteDApp_TheProposalIsStillGoingOn();
        }
        if ( SupportVotes > rejectionVotes){
            WINNER=true;
        }else if(rejectionVotes > SupportVotes){
            WINNER=false;
        }if(SupportVotes == rejectionVotes){
            revert VoteDApp_TheVotesAreEqualTryProposalAgain();
        }
        emit ProposalEnded();
        return WINNER;
    }
    ///Getter Functions///
    function GetWinner()public view returns(bool){
        if(block.timestamp < INITIALTIME+DEADLINE){
            revert VoteDApp_TheProposalIsStillGoingOn();
        }else{
            return WINNER;
        }
    }
    function getSupportVotes()public view returns(uint256){
        return SupportVotes;
    }
    function getRejectionVotes()public view returns(uint256){
        return rejectionVotes;
    } 
    function GetOwner()public view returns(address){
        return OWNER;
        }
    function GetDecimal()public pure returns(uint256){
            return DECIMALS;
        }  
    function getInitialTime()public view returns(uint256){
            return INITIALTIME;
        }
    function getDeadline()public pure returns(uint256){
        return DEADLINE;
    }
    function GetIfUserVoted(address user)public view returns(bool){
        return IfUserVoted[user];
    }
}
