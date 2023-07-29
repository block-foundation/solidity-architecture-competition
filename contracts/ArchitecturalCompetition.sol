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

    // Array to hold all the entries.
    // This is public, meaning that anyone can view the list of entries and 
    // the data associated with each entry (design URL, vote count, and competitor's address).
    Entry[] public entries;

    // Organizer's Ethereum address.
    // This is the address of the account that deploys the contract (often referred to as the contract owner).
    // Only the organizer has the authority to declare the competition's winner.
    address public organizer;

    // Entry fee for the competition specified in wei (1 ether = 10^18 wei).
    // Participants must send this amount when submitting their design in order to enter the competition.
    uint public entryFee;

    // Voting deadline as a UNIX timestamp (number of seconds since 1st January 1970).
    // After this time point, no new votes or design submissions can be made.
    uint public votingDeadline;

    // Boolean to check if a winner has been declared.
    // This defaults to false and is set to true once the organizer declares a winner after the voting deadline.
    // It prevents the winner from being changed after declaration.
    bool public isWinnerDeclared = false;

    // Entry object to hold the winning entry.
    // This is set when the organizer declares the winner.
    // It contains all the data of the winning entry (design URL, vote count, and winner's address).
    Entry public winner;

    /**
     * @dev Struct to hold the information about each entry
     * @param competitor The Ethereum address of the competitor. 
     *                   This is automatically set to the address that submits the entry.
     * @param designUrl A string representing a URL where the design can be viewed.
     *                  This is submitted by the participant when entering the competition.
     * @param voteCount The number of votes this entry has received. 
     *                  It is initially 0 and increases as other participants vote for this entry.
     */
    struct Entry {
        address payable competitor;
        string designUrl;
        uint voteCount;
    }


    // Constructor
    // ========================================================================

    /**
     * @dev Constructor to initialize the contract
     * @param _entryFee Entry fee for the competition in wei. The entry fee is set during contract deployment and 
     *                  cannot be changed afterwards. Every participant will need to send this amount of ether to 
     *                  enter the competition.
     * @param _votingDurationInDays Voting duration from the time of contract deployment, specified in days. The duration
     *                              defines how long the voting period will last. After this period, no more votes or 
     *                              entries can be submitted.
     */
    constructor(
        uint _entryFee,
        uint _votingDurationInDays
    ) {
        // The account deploying the contract is automatically set as the organizer
        organizer = msg.sender;

        // Set the entry fee for the competition
        entryFee = _entryFee;

        // Set the voting deadline by adding the specified duration (in seconds) to the current block timestamp
        votingDeadline = block.timestamp + (_votingDurationInDays * 1 days);
    }

    // Mappings
    // ========================================================================

    /**
     * @dev Mapping to keep track of who has already voted
     * @key address The Ethereum address of the participant
     * @value bool A boolean indicating whether or not the participant at the given address has voted. 
     *             Initially, this value is false for all participants. It is set to true after a participant
     *             casts their vote, preventing them from voting multiple times.
     */
    mapping(address => bool) public hasVoted;

    // Events
    // ========================================================================

    /**
     * @dev This event will be emitted when a winner is declared.
     * @param winner The Ethereum address of the winning competitor.
     * @param designUrl The URL of the winning design. It's assumed that this URL links to a platform where
     *                  the design is published, which could be an IPFS gateway, a traditional website, or any
     *                  other web-based display of the winning architectural design.
     */
    event WinnerDeclared(
        address winner,
        string designUrl
    );

    // Modifiers
    // ========================================================================

    /**
     * @dev Modifier to ensure the sender is the organizer. This is used for functions where only the organizer
     *      should have the right to execute the function, such as declaring the winner.
     */
    modifier onlyOrganizer {
        require(
            msg.sender == organizer,
            "Only the organizer can perform this action."
        );
        _;
    }

    /**
     * @dev Modifier to ensure the function is called before the voting deadline. This is used for functions
     *      where the operation should only be allowed before the voting deadline, such as submitting an entry
     *      or voting for an entry.
     */
    modifier onlyBeforeVotingDeadline {
        require(
            block.timestamp <= votingDeadline,
            "This action can't be performed after the voting deadline."
        );
        _;
    }

    /**
     * @dev Modifier to ensure the function is called after the voting deadline. This is mainly used for the
     *      function where the winner is declared, as the winner can only be declared after the voting has ended.
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
     * @dev Allows a competitor to submit an entry for the competition. 
     *      The function requires the calling address to send an amount of Ether equal to or greater 
     *      than the set entry fee. The function creates an Entry struct and pushes it to the entries array.
     *      This function can only be called before the voting deadline.
     * 
     * @param designUrl The URL where the competitor's design is hosted.
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
     * @dev Allows a participant to vote for an entry. 
     *      The function requires that the caller hasn't voted before and that the entryIndex is valid. 
     *      After a successful vote, the function increments the voteCount of the respective entry 
     *      and marks the caller as having voted. 
     *      This function can only be called before the voting deadline.
     *
     * @param entryIndex The index of the entry in the entries array that the participant wants to vote for.
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
     * @dev Allows the organizer to declare the winner after the voting deadline has passed. 
     *      The function requires that a winner hasn't been declared before. 
     *      It calculates the winner by iterating through all the entries and finding the one 
     *      with the highest vote count. The winner's details are stored and the WinnerDeclared 
     *      event is emitted. Finally, the function transfers the accumulated entry fees to the winner. 
     *      This function can only be called by the organizer and only after the voting deadline.
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
