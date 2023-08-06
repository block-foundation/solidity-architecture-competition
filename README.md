<div align="right">

  [![license](https://img.shields.io/github/license/block-foundation/solidity-architecture-competition?color=green&label=license&style=flat-square)](LICENSE.md)
  ![stars](https://img.shields.io/github/stars/block-foundation/solidity-architecture-competition?color=blue&label=stars&style=flat-square)
  ![contributors](https://img.shields.io/github/contributors/block-foundation/solidity-architecture-competition?color=blue&label=contributors&style=flat-square)

</div>

---

<div>
    <img align="right" src="https://raw.githubusercontent.com/block-foundation/brand/master/src/logo/logo_gray.png" width="96" alt="Block Foundation Logo">
    <h1 align="left">Decentralized Architectural Competition</h1>
    <h3 align="left">Block Foundation Smart Contract Series [Solidity]</h3>
</div>

---

<div>
<img align="right" width="75%" src="https://raw.githubusercontent.com/block-foundation/brand/master/src/image/repository_cover/block_foundation-structure-03-accent.jpg"  alt="Block Foundation">
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

---

<div align="right">

  ![Report a Bug](https://img.shields.io/badge/Report%20a%20Bug-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5&link=https%3A%2F%2Fgithub.com%2Fblock-foundation%2Fbrand%2Fissues%2Fnew%3Fassignees%3D%26labels%3DNeeds%253A%2BTriage%2B%253Amag%253A%252Ctype%253Abug-suspected%26template%3Dbug_report.yml)
  ![Request a Feature](https://img.shields.io/badge/Request%20a%20Feature-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5&link=https%3A%2F%2Fgithub.com%2Fblock-foundation%2Fbrand%2Fissues%2Fnew%3Fassignees%3D%26labels%3DNeeds%253A%2BTriage%2B%253Amag%253A%252Ctype%253Afeature-request%252CHelp%2Bwanted%2B%25F0%259F%25AA%25A7%26template%3Dfeature_request.yml)
  ![Ask a Question](https://img.shields.io/badge/Ask%20a%20Question-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5&link=https%3A%2F%2Fgithub.com%2Fblock-foundation%2Fbrand%2Fissues%2Fnew%3Fassignees%3D%26labels%3DNeeds%253A%2BTriage%2B%253Amag%253A%252Ctype%253Aquestion%26template%3Dquestion.yml)
  ![Make a Suggestion](https://img.shields.io/badge/Make%20a%20Suggestion-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5&link=https%3A%2F%2Fgithub.com%2Fblock-foundation%2Fbrand%2Fissues%2Fnew%3Fassignees%3D%26labels%3DNeeds%253A%2BTriage%2B%253Amag%253A%252Ctype%253Aenhancement%26template%3Dsuggestion.yml)
  ![Start a Discussion](https://img.shields.io/badge/Start%20a%20Discussion-GitHub?style=flat-square&&logoColor=%23FFFFFF&color=%23E1E4E5&link=https%3A%2F%2Fgithub.com%2Fblock-foundation%2Fbrand%2Fdiscussions)

</div>

**The "Decentralized Architectural Competition" employs the capabilities of blockchain technology to administer an architectural design competition.**

## Introduction

The smart contract permits the handling of competition entries, voting, and the announcement of the victor. This underscores how conventional architectural competitions can be reformed by incorporating blockchain technology, thereby resulting in a system that offers unalterable, secure, and decentralized processes for both the administrators and contestants.

In this construct, participants interact with the smart contract to submit their architectural design, which also necessitates an entry fee payment, thereby establishing their effective registration in the contest. The blockchain stores all entries, thus assuring their immutable nature and transparency.

Voting is conducted via the smart contract as well, facilitating a transparent vote count for each submission. The system has been devised in such a manner that each participant is permitted a single vote, and voting is restricted after a predetermined deadline.

It further includes an automated reward distribution system. Upon reaching the voting deadline and after the vote count, the prize money, which is an accumulation of the entry fees, is automatically transferred to the winner's account. This mechanism ensures an immediate reward distribution system.

This project serves as a testament to how blockchain technology can be employed to transform multiple sectors, including architectural design. The fairness, transparency, and security of the system make it an intriguing development in the realm of architectural competitions. Such decentralized systems can foster global participation and unbiased outcomes.

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

Copyright &copy; 2023 [Block Foundation](https://www.blockfoundation.io/ "Block Foundation website"). All Rights Reserved.

### License

Except as otherwise noted, the content in this repository is licensed under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/), and
code samples are licensed under the [MIT License](https://opensource.org/license/mit/).

Also see [LICENSE](https://github.com/block-foundation/community/blob/master/LICENSE) and [LICENSE-CODE](https://github.com/block-foundation/community/blob/master/LICENSE-CODE).

### Disclaimer

**THIS SOFTWARE IS PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
