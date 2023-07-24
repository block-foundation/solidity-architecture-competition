<div align="right">

  [![license](https://img.shields.io/github/license/block-foundation/solidity-architecture-competition?color=green&label=license&style=flat-square)](LICENSE.md)
  ![stars](https://img.shields.io/github/stars/block-foundation/solidity-architecture-competition?color=blue&label=stars&style=flat-square)
  ![contributors](https://img.shields.io/github/contributors/block-foundation/solidity-architecture-competition?color=blue&label=contributors&style=flat-square)

</div>

---

<div>
    <img align="right" src="https://raw.githubusercontent.com/block-foundation/brand/master/logo/logo_gray.png" width="96" alt="Block Foundation Logo">
    <h1 align="left">Decentralized Architectural Competition</h1>
    <h3 align="left">Block Foundation Smart Contract Series [Solidity]</h3>
</div>

---

<div>
<img align="right" width="75%" src="https://raw.githubusercontent.com/block-foundation/brand/master/image/repository_cover/block_foundation-structure-03-accent.jpg"  alt="Block Foundation">
<br>
<details open="open">
<summary>Table of Contents</summary>
  
- [Introduction](#style-guide)
- [Quick Start](#quick-start)
- [Contract](#contract)
- [Development Resources](#development-resources)
- [Legal Information](#legal-information)
  - [Copyright](#copyright)
  - [License](#license)
  - [Warning](#warning)
  - [Disclaimer](#disclaimer)

</details>
</div>

<br clear="both"/>

## Introduction

Welcome to the Decentralized Architectural Competition project! This groundbreaking initiative embraces the power of blockchain technology to facilitate an architectural design competition, offering a transparent, secure, and inclusive platform.

The project leverages Ethereum's and Algorand's smart contracts to handle competition entries, voting, and declaration of the winner. It demonstrates how traditional architectural competitions can be transformed using blockchain technology, which ensures an immutable, secure, and decentralized system for both the organizers and the participants.

In our system, each participant submits their architectural design by interacting with the smart contract, which also requires them to pay an entry fee, thereby effectively registering them for the competition. Participants' entries are stored on the blockchain, ensuring their immutability and transparency.

Voting is also carried out through the smart contract, allowing a transparent tally of votes for each entry. The system is designed such that each participant gets one vote, and they cannot vote after a pre-specified deadline.

Moreover, our project also includes an automatic prize distribution system. Once the voting deadline has been reached and votes are tallied, the prize money (accumulated from entry fees) is automatically transferred to the winner's account, ensuring a prompt reward system.

This project is a showcase of how we can harness blockchain's potential to transform various sectors, including architecture and design. The system's fairness, transparency, and security make it an exciting development for future architectural competitions, where decentralized systems can pave the way for global participation and unbiased results.

The following sections will delve deeper into the technicalities of our Ethereum and Algorand smart contracts, providing a comprehensive understanding of the project's inner workings. Join us in revolutionizing architectural competitions!

## Quick Start

> Install

``` sh
npm i
```

> Compile

``` sh
npm run compile
```

## Contract

The contract is deployed by the organizer of the competition. The constructor sets the organizer and entry fee.
A competitor can submit their entry using the submitEntry function. They have to send an amount equal to or greater than the entry fee.
The organizer can select the winner using the selectWinner function. They can only do this before a winner has been declared and they have to provide a valid entry index.
When the winner is selected, all the entry fees collected are transferred to the winner.
This is a basic contract. If you need a more complex or specific functionality, please provide additional details.


The smart contract includes functionality for:

- A voting mechanism where participants can vote on entries.
- Restricting one vote per address.
- Automatic distribution of prize money.
- We'll also improve on a few security aspects. Let's continue using Solidity language for this:

In this contract:

- A `voteCount` field to `Entry`, a `hasVoted` mapping to keep track of who has voted, and a `votingDeadline` to determine when voting ends.
- A `vote` function that allows people to vote on entries. Each address can only vote once, and voting can only occur before the deadline.
- A `declareWinner` function now declares the winner based on who has the most votes after the voting deadline has passed.
- We emit an event when the winner is declared.
- We also added two  modifiers to check if the current time is before or after the voting deadline.
- The winner is  declared based on voting, rather than being chosen by the organizer.
- All entry fees collected are transferred to the winner after they have been declared.

*Please note that this is still a basic example and real-world contracts would likely need additional functionality, such as more complex voting mechanisms, additional security measures, handling of ties, and more. This code has not been audited and is not recommended for use in production without further modifications and testing.*


## Development Resources

### Other Repositories

#### Block Foundation Smart Contract Series

|                                   | `Solidity`  | `Teal`      |
| --------------------------------- | ----------- | ----------- |
| **Template**                      | [**>>>**](https://github.com/block-foundation/solidity-template) | [**>>>**](https://github.com/block-foundation/teal-template) |
| **Architectural Design**          | [**>>>**](https://github.com/block-foundation/solidity-architectural-design) | [**>>>**](https://github.com/block-foundation/teal-architectural-design) |
| **Architecture Competition**      | [**>>>**](https://github.com/block-foundation/solidity-architecture-competition) | [**>>>**](https://github.com/block-foundation/teal-architecture-competition) |
| **Housing Cooporative**           | [**>>>**](https://github.com/block-foundation/solidity-housing-cooperative) | [**>>>**](https://github.com/block-foundation/teal-housing-cooperative) |
| **Land Registry**                 | [**>>>**](https://github.com/block-foundation/solidity-land-registry) | [**>>>**](https://github.com/block-foundation/teal-land-registry) |
| **Real-Estate Crowdfunding**      | [**>>>**](https://github.com/block-foundation/solidity-real-estate-crowdfunding) | [**>>>**](https://github.com/block-foundation/teal-real-estate-crowdfunding) |
| **Rent-to-Own**                   | [**>>>**](https://github.com/block-foundation/solidity-rent-to-own) | [**>>>**](https://github.com/block-foundation/teal-rent-to-own) |
| **Self-Owning Building**          | [**>>>**](https://github.com/block-foundation/solidity-self-owning-building) | [**>>>**](https://github.com/block-foundation/teal-self-owning-building) |
| **Smart Home**                    | [**>>>**](https://github.com/block-foundation/solidity-smart-home) | [**>>>**](https://github.com/block-foundation/teal-smart-home) |

## Legal Information

### Copyright

Copyright 2023, [Stichting Block Foundation](https://www.blockfoundation.io). All rights reserved.

### License

Except as otherwise noted, the content in this repository is licensed under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/), and
code samples are licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).

Also see [LICENSE](https://github.com/block-foundation/community/blob/master/LICENSE) and [LICENSE-CODE](https://github.com/block-foundation/community/blob/master/LICENSE-CODE).

### Warning

**Please note that this code should be audited by a professional smart-contract auditor before being used in a production environment as it is a simplified example and may not cover all potential security vulnerabilities.**

### Disclaimer

**THIS SOFTWARE IS PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
