# GameSession Smart Contract - Metacrafters Eth+Avax Intermediate

This Solidity-based smart contract facilitates the creation and management of game sessions on the Ethereum blockchain. Players can join or leave game sessions, and the contract allows the admin to create, manage, and deactivate game sessions. It is designed to enable multiplayer gaming systems or as a component for decentralized gaming applications.

## Table of Contents
1. [Overview](#overview)
2. [Contract Structure](#contract-structure)
3. [Functions](#functions)
4. [Deployment](#deployment)
5. [Usage](#usage)
6. [License](#license)

---

## Overview

The `GameSession` contract allows an admin to create game sessions, and players to join or leave these sessions. The system ensures that no game exceeds the maximum number of players and provides basic management features like checking game details and deactivating games.

### Key Features:
- Admin can create new game sessions with a name and maximum number of players.
- Players can join or leave an active game session.
- The contract maintains the current number of players in each game and prevents players from joining full games.
- Admin can deactivate any game session, marking it as inactive and preventing new players from joining.

---

## Contract Structure

### 1. **Game Struct**
This struct stores information about each game session:
- `id`: Unique identifier for the game.
- `name`: Name of the game.
- `maxPlayers`: Maximum number of players allowed in the game.
- `currentPlayers`: Current number of players in the game.
- `isActive`: A boolean flag indicating whether the game is still active or not.

### 2. **Player Struct**
This struct holds data about each player:
- `isInGame`: Boolean flag indicating whether the player is currently in a game.
- `joinedGameId`: The ID of the game the player has joined.

### 3. **State Variables**
- `admin`: The address of the contract deployer, who has administrative privileges.
- `gamesCount`: Counter to keep track of the total number of games created.
- `games`: A mapping of game IDs to the `Game` struct.
- `players`: A mapping of player addresses to the `Player` struct.

### 4. **Modifiers**
- `onlyAdmin`: Restricts certain functions to be executed only by the admin.

---

## Functions

### 1. **createGame**
```solidity
function createGame(string memory _name, uint _maxPlayers) public onlyAdmin;
```
- **Description**: Allows the admin to create a new game session with a specified name and maximum number of players.
- **Parameters**:
  - `_name`: Name of the game session.
  - `_maxPlayers`: Maximum number of players allowed in the game.
- **Requires**: Only the admin can call this function.

### 2. **joinGame**
```solidity
function joinGame(uint _gameId) public;
```
- **Description**: Allows a player to join an existing game session.
- **Parameters**:
  - `_gameId`: The ID of the game the player wants to join.
- **Requires**:
  - The player is not already in a game.
  - The game exists and is still active.
  - The game has not yet reached the maximum number of players.

### 3. **leaveGame**
```solidity
function leaveGame() public;
```
- **Description**: Allows a player to leave a game session they are currently in.
- **Requires**: The player must be in a game to leave.

### 4. **getGame**
```solidity
function getGame(uint _gameId) public view returns (string memory name, uint maxPlayers, uint currentPlayers, bool isActive);
```
- **Description**: Retrieves the details of a game session.
- **Parameters**:
  - `_gameId`: The ID of the game to retrieve information about.
- **Returns**: The name, maximum players, current players, and active status of the game.

### 5. **deactivateGame**
```solidity
function deactivateGame(uint _gameId) public onlyAdmin;
```
- **Description**: Allows the admin to deactivate a game session, making it inactive.
- **Parameters**:
  - `_gameId`: The ID of the game to deactivate.
- **Requires**: Only the admin can call this function.

---

## Deployment

1. **Prerequisites**:
   - You will need an Ethereum development environment such as [Remix](https://remix.ethereum.org/), [Truffle](https://www.trufflesuite.com/), or [Hardhat](https://hardhat.org/).
   - The contract is written in Solidity version 0.8.0, so ensure your environment supports this version or above.

2. **Deploy the Contract**:
   - Deploy the `GameSession` contract to the Ethereum network or a test network like Rinkeby or Goerli using your preferred Ethereum deployment tool.

---

## Usage

### 1. **Creating a Game Session**
The admin (the deployer of the contract) can call `createGame` to create a new game session with a specific name and a maximum number of players:
```solidity
createGame("Battle Royale", 5);
```
This creates a game named "Battle Royale" with a maximum of 5 players.

### 2. **Joining a Game**
Players can join an existing game session by providing the game ID:
```solidity
joinGame(1);
```
This joins the game with ID `1`.

### 3. **Leaving a Game**
Players can leave the game they are currently in:
```solidity
leaveGame();
```

### 4. **Getting Game Details**
Anyone can view the details of a game session:
```solidity
getGame(1);
```
This returns the name, max players, current players, and active status of the game with ID `1`.

### 5. **Deactivating a Game Session**
The admin can deactivate a game session, making it inactive and preventing further players from joining:
```solidity
deactivateGame(1);
```

---

## License

This contract is released under the [MIT License](https://opensource.org/licenses/MIT). See the LICENSE file for more details.

---

## Disclaimer

This smart contract is for educational purposes and may require additional testing and security audits before deployment in a production environment. Always exercise caution and ensure the contract is thoroughly reviewed and tested for vulnerabilities.
