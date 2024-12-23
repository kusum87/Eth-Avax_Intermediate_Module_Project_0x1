// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GameSession {

    struct Game {
        uint id;
        string name;
        uint maxPlayers;
        uint currentPlayers;
        bool isActive;
    }

    struct Player {
        bool isInGame;
        uint joinedGameId;
    }

    address public admin;
    uint public gamesCount;
    mapping(uint => Game) public games;
    mapping(address => Player) public players;

    constructor() {
        admin = msg.sender;  // Contract deployer is the game admin
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    //creating a new game session
    function createGame(string memory _name, uint _maxPlayers) public onlyAdmin {
        require(_maxPlayers > 0, "Max players should be greater than zero");

        gamesCount++;
        games[gamesCount] = Game(gamesCount, _name, _maxPlayers, 0, true);
    }

    //join a game session
    function joinGame(uint _gameId) public {
        Player storage player = players[msg.sender];
        Game storage game = games[_gameId];

        require(_gameId > 0 && _gameId <= gamesCount, "Invalid game ID");

        require(!player.isInGame, "You are already in a game");

        require(game.isActive, "This game session is no longer active");

        require(game.currentPlayers < game.maxPlayers, "This game is full");

 
        player.isInGame = true;
        player.joinedGameId = _gameId;

        game.currentPlayers++;
    }

    //leave a game session
    function leaveGame() public {
        Player storage player = players[msg.sender];

        require(player.isInGame, "You are not in any game");

        uint joinedGameId = player.joinedGameId;
        Game storage game = games[joinedGameId];

        game.currentPlayers--;

        //resetting player status
        player.isInGame = false;
        player.joinedGameId = 0;
    }

    //get details of a game session
    function getGame(uint _gameId) public view returns (string memory name, uint maxPlayers, uint currentPlayers, bool isActive) {
        assert(_gameId > 0 && _gameId <= gamesCount);

        Game memory game = games[_gameId];
        return (game.name, game.maxPlayers, game.currentPlayers, game.isActive);
    }

    //deactivate a game session
    function deactivateGame(uint _gameId) public onlyAdmin {
        Game storage game = games[_gameId];

        require(_gameId > 0 && _gameId <= gamesCount, "Invalid game ID");

        if (!game.isActive) {
            revert("The game is already inactive");
        }
        game.isActive = false;
    }
}
