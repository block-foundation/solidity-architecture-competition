<div align="right">

[![GitHub License](https://img.shields.io/github/license/block-foundation/blocktxt?style=flat-square&logo=readthedocs&logoColor=FFFFFF&label=&labelColor=%23041B26&color=%23041B26&link=LICENSE)](https://github.com/block-foundation/solidity-architecture-competition/blob/main/LICENSE)
[![devContainer](https://img.shields.io/badge/Container-Remote?style=flat-square&logo=visualstudiocode&logoColor=%23FFFFFF&label=Remote&labelColor=%23041B26&color=%23041B26)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/block-foundation/solidity-architecture-competition)

</div>

---

<div>
    <img align="right" src="https://raw.githubusercontent.com/block-foundation/brand/master/src/logo/logo_gray.png" width="96" alt="Block Foundation Logo">
    <h1 align="left">Decentralized Architectural Competition</h1>
    <h3 align="left">Block Foundation Smart Contract Series [Solidity]</h3>
</div>

---

<img align="right" width="75%" src="https://raw.githubusercontent.com/block-foundation/brand/master/src/image/repository_cover/block_foundation-structure-03-accent.jpg"  alt="Block Foundation Brand">

### Contents

- [Introduction](#introduction)
- [Colophon](#colophon)

<br clear="both"/>

---

<div align="right">

[![Report a Bug](https://img.shields.io/badge/Report%20a%20Bug-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5)](https://github.com/block-foundation/solidity-architecture-competition/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&projects=&template=bug_report.yml)
[![Request a Feature](https://img.shields.io/badge/Request%20a%20Feature-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5)](https://github.com/block-foundation/solidity-architecture-competition/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&projects=&template=feature_request.yml)
[![Ask a Question](https://img.shields.io/badge/Ask%20a%20Question-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5)](https://github.com/block-foundation/solidity-architecture-competition/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&projects=&template=question.yml)
[![Make a Suggestion](https://img.shields.io/badge/Make%20a%20Suggestion-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5)](https://github.com/block-foundation/solidity-architecture-competition/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&projects=&template=suggestion.yml)
[![Start a Discussion](https://img.shields.io/badge/Start%20a%20Discussion-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5)](https://github.com/block-foundation/solidity-architecture-competition/issues/new?assignees=&labels=Needs%3A+Triage+%3Amag%3A%2Ctype%3Abug-suspected&projects=&template=discussion.yml)

</div>

**Welcome to the Decentralized Architectural Competition project, a smart contract that integrates the robustness of blockchain technology to administer an architectural design competition.**

## Introduction

The smart contract permits the handling of competition entries, voting, and the announcement of the victor. This underscores how conventional architectural competitions can be reformed by incorporating blockchain technology, thereby resulting in a system that offers unalterable, secure, and decentralized processes for both the administrators and contestants.

In this construct, participants interact with the smart contract to submit their architectural design, which also necessitates an entry fee payment, thereby establishing their effective registration in the contest. The blockchain stores all entries, thus assuring their immutable nature and transparency.

Voting is conducted via the smart contract as well, facilitating a transparent vote count for each submission. The system has been devised in such a manner that each participant is permitted a single vote, and voting is restricted after a predetermined deadline.

It further includes an automated reward distribution system. Upon reaching the voting deadline and after the vote count, the prize money, which is an accumulation of the entry fees, is automatically transferred to the winner's account. This mechanism ensures an immediate reward distribution system.

This project serves as a testament to how blockchain technology can be employed to transform multiple sectors, including architectural design. The fairness, transparency, and security of the system make it an intriguing development in the realm of architectural competitions. Such decentralized systems can foster global participation and unbiased outcomes.

## Features

- **Immutable Entries**: Each participant submits their design via the smart contract. The entries, stored on the blockchain, ensure immutability and transparency.
- **Transparent Voting**: Voting happens through the smart contract. Each participant gets one vote and cannot vote post the pre-specified deadline.
- **Automatic Prize Distribution**: Once the voting ends, the prize money, accumulated from the entry fees, is auto-transferred to the winner's account, ensuring swift and fair reward distribution.

## Getting Started

### Prerequisites

- Install [Node.js](https://nodejs.org/)
- Install [Ethereum's development framework, Truffle](https://www.trufflesuite.com/)

### Installation

1. Clone the repository:

``` bash
git clone https://github.com/yourGitHubUsername/DecentralizedArchitecturalCompetition.git
```

2. Change into the project directory:

``` bash
cd DecentralizedArchitecturalCompetition
```

3. Install dependencies:

``` bash
npm install
```

### Deployment

1. Compile the smart contract:

``` bash
truffle compile
```

2. Deploy the smart contract:

```bash
truffle migrate --network yourPreferredNetwork
```

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

_Please note that this is still a basic example and real-world contracts would likely need additional functionality, such as more complex voting mechanisms, additional security measures, handling of ties, and more. This code has not been audited and is not recommended for use in production without further modifications and testing._

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

---

## Colophon

### Authors

This is an open-source project by the **[Block Foundation](https://www.blockfoundation.io "Block Foundation website")**.

The Block Foundation mission is enabling architects to take back initiative and contribute in solving the mismatch in housing through blockchain technology. Therefore the Block Foundation seeks to unschackle the traditional constraints and construct middle ground between rent and the rigidity of traditional mortgages.

website: [www.blockfoundation.io](https://www.blockfoundation.io "Block Foundation website")

### Development Resources

#### Contributing

We'd love for you to contribute and to make this project even better than it is today!
Please refer to the [contribution guidelines](.github/CONTRIBUTING.md) for information.

### Legal Information

#### Copyright

Copyright &copy; 2023 [Stichting Block Foundation](https://www.blockfoundation.io/ "Block Foundation website"). All Rights Reserved.

#### License

Except as otherwise noted, the content in this repository is licensed under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/), and
code samples are licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).

Also see [LICENSE](https://github.com/block-foundation/community/blob/master/src/LICENSE) and [LICENSE-CODE](https://github.com/block-foundation/community/blob/master/src/LICENSE-CODE).

#### Disclaimer

**THIS SOFTWARE IS PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
