# Multiplayer Pong (Godot)

A classic Pong implementation built with Godot featuring **online multiplayer support**.  
Players can connect to a dedicated server and compete in real time while additional users can join as spectators.

## Features

- Online multiplayer using a dedicated server
- Up to **2 players per match**
- Additional connections join as **spectators**
- **Infinite gameplay** (no score limit)
- Simple server-client architecture

## Running the Server

To start the game server, launch the project with the following argument:
--server

This will start the game in **server mode**, allowing clients to connect.

## Connecting as a Client

Clients must connect using the **IP address and port** configured in the `GameManager` script.

If needed, you can modify these values directly in the file:
game_manager.gd

Example configuration:
server_ip = "127.0.0.1"
server_port = 12345

## Gameplay Rules

- The game allows **only two active players**.
- Any additional connections will automatically become **spectators**.
- The match runs **indefinitely** — there is **no score limit**.

## Requirements

- Godot Engine (recommended version: 4.6.1)

## Running the Game

1. Start the server with the `--server` argument.
2. Launch the game normally for clients.
3. Connect to the server using the configured IP and port.
4. If two players are already connected, new users will join as spectators.

## Future Improvements

- Lobby system
- Player matchmaking
- Score limit configuration
- UI improvements
