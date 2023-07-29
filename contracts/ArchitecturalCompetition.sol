// SPDX-License-Identifier: Apache-2.0


// Copyright 2023 Stichting Block Foundation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


pragma solidity ^0.8.19;


/**
 * @title ArchitecturalCompetition
 * @dev This contract is designed to facilitate a decentralized architectural design competition.
 * It handles submissions, voting, and winner declaration.
 */
contract ArchitecturalCompetition {

    // State variables
    // ========================================================================

    // Array to hold all the entries
    Entry[] public entries;

    // Organizer's address
    address public organizer;

    // Entry fee for the competition in wei
    uint public entryFee;

    // Voting deadline as a UNIX timestamp
    uint public votingDeadline;

    // Boolean to check if a winner has been declared
    bool public isWinnerDeclared = false;

    // Entry object to hold the winning entry
    Entry public winner;

    /**
     * @dev Struct to hold the information about each entry
     */
    struct Entry {
        address payable competitor; // Address of the competitor
        string designUrl; // URL of the design
        uint voteCount; // Count of votes received
    }

    // Constructor
    // ========================================================================

    /**
     * @dev Constructor to initialize the contract
     * @param _entryFee Entry fee for the competition in wei
     * @param _votingDurationInDays Voting duration from the deployment of contract in days
     */
    constructor(
        uint _entryFee,
        uint _votingDurationInDays
    ) {
        organizer = msg.sender;
        entryFee = _entryFee;
        votingDeadline = block.timestamp + (_votingDurationInDays * 1 days);
    }

    // Mappings
    // ========================================================================

    // Mapping to keep track of who has already voted
    mapping(address => bool) public hasVoted;

    // Events
    // ========================================================================

    /**
     * @dev Event that will be emitted when a winner is declared
     */
    event WinnerDeclared(
        address winner,
        string designUrl
    );

    // Modifiers
    // ========================================================================

    /**
     * @dev Modifier to check if the sender is the organizer
     */
    modifier onlyOrganizer {
        require(
            msg.sender == organizer,
            "Only the organizer can perform this action."
        );
        _;
    }

    /**
     * @dev Modifier to check if the current time is before the voting deadline
     */
    modifier onlyBeforeVotingDeadline {
        require(
            block.timestamp <= votingDeadline,
            "This action can't be performed after the voting deadline."
        );
        _;
    }

    /**
     * @dev Modifier to check if the current time is after the voting deadline
     */
    modifier onlyAfterVotingDeadline {
        require(
            block.timestamp > votingDeadline,
            "This action can only be performed after the voting deadline."
        );
        _;
    }

    // Functions
    // ========================================================================

    /**
     * @dev Function to submit an entry for the competition
     * @param designUrl URL of the design
     */
    function submitEntry(
        string memory designUrl
    ) public payable onlyBeforeVotingDeadline {
        require(
            msg.value >= entryFee,
            "Entry fee is required to participate in the competition."
        );

        entries.push(
            Entry(
                {
                    competitor: payable(msg.sender),
                    designUrl: designUrl,
                    voteCount: 0
                }
            )
        );
    }

    /**
     * @dev Function for a participant to vote for an entry
     * @param entryIndex Index of the entry in the entries array
     */
    function vote(
        uint entryIndex
    ) public onlyBeforeVotingDeadline {
        require(
            !hasVoted[msg.sender],
            "You have already voted."
        );

        require(
            entryIndex < entries.length,
            "Invalid entry index."
        );

        entries[entryIndex].voteCount++;

        hasVoted[msg.sender] = true;
    }

    /**
     * @dev Function for the organizer to declare the winner after the voting deadline
     */
    function declareWinner() public onlyOrganizer onlyAfterVotingDeadline {
        require(
            !isWinnerDeclared,
            "Winner has already been declared."
        );

        uint winningVoteCount = 0;
        uint winningIndex = 0;

        for (uint i = 0; i < entries.length; i++) {
            if (entries[i].voteCount > winningVoteCount) {
                winningVoteCount = entries[i].voteCount;
                winningIndex = i;
            }
        }

        winner = entries[winningIndex];
        isWinnerDeclared = true;

        emit WinnerDeclared(winner.competitor, winner.designUrl);

        // Transfer the collected entry fees to the winner
        winner.competitor.transfer(address(this).balance);
    }
}
