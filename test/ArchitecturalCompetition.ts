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


import { ethers } from "hardhat";
import chai from "chai";
import { solidity } from "ethereum-waffle";
import chaiAsPromised from "chai-as-promised";
import { ArchitecturalCompetition } from "../typechain/ArchitecturalCompetition";


chai.use(solidity);
chai.use(chaiAsPromised);


const { expect } = chai;


// This suite tests the functionality of the ArchitecturalCompetition contract
describe("ArchitecturalCompetition", () => {

    let competition: ArchitecturalCompetition;
    
    // Entry fee is 1 ether
    const entryFee = ethers.utils.parseEther("1");

    // Voting duration is set to 7 days
    const votingDurationInDays = 7; 

    // Before each test, a new instance of the ArchitecturalCompetition 
    // contract is deployed
    beforeEach(async () => {
        const CompetitionFactory = await ethers.getContractFactory(
            "ArchitecturalCompetition"
        );
        competition = (await CompetitionFactory.deploy(
        entryFee, votingDurationInDays)) as ArchitecturalCompetition;
        await competition.deployed();
    });

    // This test ensures that the contract is deployed properly
    it("Should be deployed properly", async () => {
        expect(competition.address).to.properAddress;
    });

    // This test verifies that a competitor can submit an entry with the valid
    // fee
    it("Should allow entry submission with valid fee", async () => {

        const [_, competitor] = await ethers.getSigners();
        await expect(
            competition.connect(competitor).submitEntry(
                "https://design.com/entry1",
                { value: entryFee }
            )
        ).to.not.be.reverted;

    });

    // This test verifies that a competitor cannot submit an entry with an
    // insufficient fee
    it("Should reject entry submission with insufficient fee", async () => {

        const [_, competitor] = await ethers.getSigners();

        const insufficientFee = ethers.utils.parseEther("0.5"); // 0.5 ether

        await expect(
            competition.connect(competitor).submitEntry(
                "https://design.com/entry1",
                { value: insufficientFee }
            )
        ).to.be.revertedWith(
            "Entry fee is required to participate in the competition."
        );

    });

    // This test ensures that voting is allowed before the voting deadline
    it("Should allow voting before deadline", async () => {

        const [_, voter, competitor] = await ethers.getSigners();

        await competition.connect(competitor).submitEntry(
            "https://design.com/entry1",
            { value: entryFee }
        );

        await expect(competition.connect(voter).vote(0)).to.not.be.reverted;

    });

    // This test checks that voting is not allowed after the voting deadline
    it("Should not allow voting after deadline", async () => {

        const [_, voter, competitor] = await ethers.getSigners();

        await competition.connect(competitor).submitEntry(
            "https://design.com/entry1",
            { value: entryFee }
        );

        // fast-forward past the voting deadline
        await ethers.provider.send(
            "evm_increaseTime",
            [votingDurationInDays * 24 * 60 * 60]
        );

        await ethers.provider.send("evm_mine", []);

        await expect(competition.connect(voter).vote(0)).to.be.revertedWith(
            "This action can't be performed after the voting deadline."
        );

    });

    // This test ensures that the winner cannot be declared before the
    // voting deadline
    it("Should not allow declaring the winner before deadline", async () => {

        const [organizer] = await ethers.getSigners();

        await expect(
            competition.connect(organizer).declareWinner()
        ).to.be.revertedWith(
            "This action can only be performed after the voting deadline."
        );

    });

    // This test checks that the winner can be declared after the voting 
    // deadline
    it("Should allow declaring the winner after deadline", async () => {

        const [organizer, competitor] = await ethers.getSigners();

        await competition.connect(competitor).submitEntry(
            "https://design.com/entry1",
            { value: entryFee }
        );

        // fast-forward past the voting deadline
        await ethers.provider.send(
            "evm_increaseTime",
            [votingDurationInDays * 24 * 60 * 60]
        );

        await ethers.provider.send("evm_mine", []);

        await expect(competition.connect(organizer).declareWinner()).to.emit(
            competition,
            "WinnerDeclared"
        );

    });

    // This test ensures that the winner can not be declared more than once
    it("Should not allow declaring the winner more than once", async () => {

        const [organizer, competitor] = await ethers.getSigners();

        await competition.connect(competitor).submitEntry(
            "https://design.com/entry1",
            { value: entryFee }
        );

        // fast-forward past the voting deadline
        await ethers.provider.send(
            "evm_increaseTime",
            [votingDurationInDays * 24 * 60 * 60]
        );

        await ethers.provider.send("evm_mine", []);

        await competition.connect(organizer).declareWinner();

        await expect(
            competition.connect(organizer).declareWinner()
        ).to.be.revertedWith(
            "Winner has already been declared."
        );

    });

});
