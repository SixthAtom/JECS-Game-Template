# JECS Game Template

A Roblox game template built with JECS (Entity Component System) for Luau, providing a solid foundation for scalable game development.

## Overview

This template uses JECS under the hood to create a usable environment for development. It provides a structured ECS architecture split across Client, Server, and Shared modules, making it easy to build complex games with clean separation of concerns.

**THIS IS A TEMPLATE** - Designed to be forked and customized for your specific game needs.

## Features

- **JECS Integration**: Full Entity Component System implementation for performant game logic
- **Modular Architecture**: Clean separation between Client, Server, and Shared code
- **Package Management**: Wally for dependency management
- **Build Tools**: Rojo for seamless Roblox Studio integration
- **Type Safety**: Full Luau type annotations throughout

## Prerequisites

- [Roblox Studio](https://create.roblox.com/)
- [Aftman](https://github.com/LPGhatguy/aftman) (for tool management)
- [Wally](https://github.com/UpliftGames/wally) (installed via Aftman)

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/JECS-Game-Template.git
   cd JECS-Game-Template
   ```

2. **Install tools with Aftman:**

   ```bash
   aftman install
   ```

3. **Install packages with Wally:**

   ```bash
   wally install
   ```

4. **Load package types:**

   ```bash
   rojo sourcemap default.project.json --output sourcemap.json
   wally-package-types --sourcemap sourcemap.json Packages/
   wally-package-types --sourcemap sourcemap.json ServerPackages/
   ```

   Or use the provided VS Code task: `Load Package Types`

## Project Structure

```
├── src/
│   ├── Client/                 # Client-side code
│   │   ├── ECS/                # Client ECS modules
│   │   │   ├── Components/     # Client component definitions
│   │   │   └── Entities/       # Client entity constructors
│   │   ├── Client.client.luau  # Main client entry point
│   │   └── __LoadOrder.luau    # Client load order
│   ├── Server/                 # Server-side code
│   │   ├── ECS/                # Server ECS modules
│   │   │   ├── Components/     # Server component definitions
│   │   │   └── Entities/       # Server entity constructors
│   │   ├── Server.server.luau  # Main server entry point
│   │   └── __LoadOrder.luau    # Server load order
│   └── Shared/                 # Shared code
│       ├── ECS/                # Shared ECS modules
│       │   ├── Components/     # Shared component definitions
│       │   └── Worlds.luau     # ECS world definitions
│       └── Util/               # Shared utilities
├── Packages/                   # Wally packages (client/server)
├── ServerPackages/             # Server-only Wally packages
├── default.project.json        # Rojo project configuration
├── wally.toml                  # Wally dependencies
├── aftman.toml                 # Tool versions
└── README.md                   # This file
```

## Development Setup

1. **Open in Roblox Studio:**

   ```bash
   rojo serve
   ```

   Then open Roblox Studio and connect to the Rojo server.

2. **Development Workflow:**
   - Make changes in the `src/` directory
   - Use Rojo to sync changes to Roblox Studio
   - Test in Roblox Studio
   - Commit changes when ready

3. **Building for Production:**
   ```bash
   rojo build --output game.rbxlx
   ```

## ECS Architecture

This template uses JECS for its Entity Component System. For detailed information on setting up components and entities, see [ECS-Setup-README.md](ECS-Setup-README.md).

### Key Concepts

- **Worlds**: Separate ECS worlds for client and server (not shared)
- **Components**: Data structures attached to entities
- **Entities**: Objects composed of components
- **Systems**: Logic that operates on entities with specific components

### Quick Start

```luau
-- Create an entity with components
local world = require(ReplicatedStorage.Shared.ECS.Worlds).Default
local components = require(ReplicatedStorage.Client.ECS.Components).Default
local entity = world:entity()

world:set(entity, components.Name, "My Entity")
world:set(entity, components.Id, 123)
```

## Dependencies

### Runtime Dependencies

- **JECS**: Entity Component System for Luau

### Development Dependencies

- **Rojo**: Project syncing between filesystem and Roblox Studio
- **Wally**: Package management for Luau
- **Aftman**: Toolchain management

## Scripts and Tasks

The project includes VS Code tasks for common operations:

- **Load Package Types**: Installs and generates type definitions for Wally packages

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly in Roblox Studio
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

- [JECS Documentation](https://github.com/ukendio/jecs)
- [Rojo Documentation](https://rojo.space/)
- [Wally Documentation](https://wally.run/)

## Changelog

### v1.0.0

- Initial release
- JECS integration
- Basic ECS architecture
- Package management setup
- Build tooling configuration
