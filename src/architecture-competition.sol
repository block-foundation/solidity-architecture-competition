// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ArchitecturalCompetition {

    struct Entry {
        address payable competitor;
        string designUrl;
        bool isSubmitted;
    }

    address public organizer;
    Entry[] public entries;
    address payable public winner;
    bool public isWinnerDeclared = false;
    uint public entryFee;
    
    constructor(uint _entryFee) {
        organizer = msg.sender;
        entryFee = _entryFee;
    }

    modifier onlyOrganizer {
        require(msg.sender == organizer, "Only the organizer can perform this action.");
        _;
    }

    modifier onlyBeforeWinnerDeclaration {
        require(!isWinnerDeclared, "This action can't be performed after winner declaration.");
        _;
    }
    
    function submitEntry(string memory designUrl) public payable onlyBeforeWinnerDeclaration {
        require(msg.value >= entryFee, "Entry fee is required to participate in the competition.");
        entries.push(Entry({
            competitor: payable(msg.sender),
            designUrl: designUrl,
            isSubmitted: true
        }));
    }

    function selectWinner(uint entryIndex) public onlyOrganizer onlyBeforeWinnerDeclaration {
        require(entryIndex < entries.length, "Invalid entry index.");
        require(entries[entryIndex].isSubmitted, "The selected entry was not submitted.");
        
        winner = entries[entryIndex].competitor;
        isWinnerDeclared = true;
        
        // Transfer the collected entry fees to the winner
        winner.transfer(address(this).balance);
    }
}
