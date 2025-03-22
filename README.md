# 🗳 VoteDApp

## 🌟 Overview
VoteDApp is a **decentralized voting application** built on Solidity, allowing users to vote on proposals using a custom ERC20 token. The contract ensures fairness by requiring users to hold a minimum balance of the token before participating in the vote. The voting process is time-bound, ensuring transparent decision-making.

## ✨ Features
✅ **Decentralized Voting** – Users vote using a tokenized voting power system.  
✅ **Token-Based Participation** – Users must hold and transfer tokens to vote.  
✅ **Owner-Restricted Election Process** – Only the contract owner can finalize the election.  
✅ **Time-Limited Proposals** – Voting ends after a set deadline (**1 month**).  
✅ **Secure & Transparent** – Prevents multiple voting attempts & ensures fairness.  

---
## 📜 Smart Contract Details

### ⚠️ Errors
❌ `VoteDApp_YouShouldHoldMoreVT` – User must hold more tokens to vote.  
❌ `VoteDApp_YouHaveVotedBefore` – User has already voted.  
❌ `VoteDApp_ParticipateFailed` – Token transfer failed.  
❌ `VoteDApp_TheProposalIsStillGoingOn` – Voting period is not over.  
❌ `VoteDApp_TheVotesAreEqualTryProposalAgain` – Votes are tied; proposal should be restarted.  
❌ `VoteDApp_OnlyOwnerCanCallThisFunction` – Only the owner can execute specific functions.  

### 📢 Events
📌 `userVoted(address user, bool vote)` – Logs a user’s vote.  
📌 `ProposalEnded()` – Emitted when voting concludes.  

### 📊 Contract Variables
- 📈 `SupportVotes` – Number of support votes.  
- 📉 `rejectionVotes` – Number of rejection votes.  
- 🏆 `WINNER` – Stores the election result.  
- 🔢 `DECIMALS` – Token decimal value.  
- 👑 `OWNER` – The contract owner.  
- ⏳ `DEADLINE` – Voting period (**1 month**).  
- 🕰 `INITIALTIME` – Voting start time.  

---
## ⚙️ Functions
### 🗳 **Voting Functions**
🔹 `participate(bool Vote)` – Allows users to vote by transferring tokens.  
🔹 `election()` – Ends the voting process and determines the winner (**owner-only**).  

### 📡 **Getter Functions**
🔍 `GetWinner()` – Returns the election result.  
📊 `getSupportVotes()` – Retrieves support votes count.  
📉 `getRejectionVotes()` – Retrieves rejection votes count.  
👑 `GetOwner()` – Returns the contract owner.  
🔢 `GetDecimal()` – Returns token decimal value.  
🕰 `getInitialTime()` – Returns the voting start time.  
⏳ `getDeadline()` – Returns the voting deadline.  
🗂 `GetIfUserVoted(address user)` – Checks if a user has voted.  

---
## 🚀 Installation & Deployment
1. **Clone the Repository:**  
   ```sh
   git clone https://github.com/Elmirataghinasab/basic-VotingDapp.git
   cd basic-VotingDapp
   ```
2. **Install Foundry:**  
   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```
3. **Compile the Contract:**  
   ```sh
   forge build
   ```
4. **Run Tests:**  
   ```sh
   forge test
   ```

---
## 🤝 Contributing
Contributions are welcome! Please open an **issue** or submit a **pull request**.

---
## 📜 License
This project is licensed under the **MIT License**.

---
## 📬 Contact
For inquiries, reach out via **GitHub issues** or email: [taghinasab8395@gmail.com](mailto:taghinasab8395@gmail.com).

