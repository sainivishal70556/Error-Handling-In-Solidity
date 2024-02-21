//SPDX-License-Identifier: MIT
//Error handling in Solidity primarily involves using the require, assert, and revert 
//statements to check conditions and revert transactions when necessary.Let us discuss 
//all about three.

    // Require should be used to validate conditions such as:
    // - inputs
    // - conditions before execution
    // - return values from calls to other functions

    // Assert should only be used to test for internal errors,
    // and to check invariants.
    // Here we assert that num is always equal to 0
    // since it is impossible to update the value of num

    // This function deliberately causes an error by reverting the transaction
    // Revert is useful when the condition to check is complex.
    // This code does the exact same thing as the example above

//This contract represents a simple voting system where users can vote yes or no on a 
//proposal. Each user can only vote once. The contract keeps track of the number of yes and
// no votes, and users can query the result of the vote through the getResult function.
pragma solidity ^0.8.0;

contract VotingSystem {
    mapping(address => bool) public hasVoted;
    uint public yesVotes;
    uint public noVotes;

    event Voted(address indexed voter, bool vote);

    function vote(bool inSupport) external {
        require(!hasVoted[msg.sender], "You have already voted");
        
        if (inSupport) {
            yesVotes++;
        } else {
            noVotes++;
        }

        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, inSupport);
    }

    function getResult() external view returns (string memory) {
        if (yesVotes > noVotes) {
            return "Proposal accepted";
        } else if (noVotes > yesVotes) {
            return "Proposal rejected";
        } else {
            return "Proposal tied";
        }
    }
}


