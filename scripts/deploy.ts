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


// Importing the ethers object from hardhat
import { ethers } from "hardhat"


/**
 *  @function main
 *  @dev The main function of the deployment script. It deploys the contract 
 *  and logs the account  used for deployment and the address of the
 *  deployed contract.
 */
async function main() {

    // Get the account used for deployment
    const [deployer] = await ethers.getSigners();

    console.log(
        "Deploying the contracts with the account:",
        deployer.address
    );

    // Get and log the balance of the deployer account
    console.log(
        "Account balance:",
        (await deployer.getBalance()).toString()
    );

    // Get the contract factory for the ArchitecturalCompetition contract
    const ArchitecturalCompetition = await ethers.getContractFactory(
        "ArchitecturalCompetition"
    );
    
    // Deploy the contract with an entry fee of 1 ether and a voting 
    // duration of 7 days
    const competition = await ArchitecturalCompetition.deploy(
        ethers.utils.parseEther("1"),
        7
    );

    // Wait for the contract to be deployed
    await competition.deployed();

    // Log the address of the deployed contract
    console.log(
        "ArchitecturalCompetition contract deployed to:",
        competition.address
    );
}

/**
 *  @function main
 *  @dev Entry point of the script. Calls the main function and handles errors
 *  and exit codes.
 */
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
