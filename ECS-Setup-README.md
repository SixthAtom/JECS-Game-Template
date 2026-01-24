# ECS Setup Guide

This guide explains how to set up and use components and entities in this JECS-based game template.

## Overview

The project uses JECS (an Entity Component System library for Luau/Roblox) to manage game entities and their components. The ECS architecture is split across Client, Server, and Shared modules.

## World Setup

The ECS world is created in `src/Shared/ECS/Worlds.luau`:

```luau
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

return {
    Default = jecs.world(),
}
```

**Important**: Worlds are shared solely on the client OR the server - they are not cross-shared between client and server. The same world instance exists separately on each side, allowing for client-side prediction and server-side authority.

All entities and components exist within their respective world instances.

### Creating New Worlds

To create a new world:

1. Open `src/Shared/ECS/Worlds.luau`
2. Add a new world to the returned table:

```luau
return {
    Default = jecs.world(),
    MyNewWorld = jecs.world(),
}
```

3. Create a new components module for this world (e.g., `src/Shared/ECS/Components/MyNewWorld.luau`):

```luau
local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

local WORLD = Worlds.MyNewWorld

return {
    MyComponent = WORLD:component() :: Id<string>,
    MyTag = jecs.tag(),
}
```

4. Add the new components to the respective `init.luau` file (e.g., `src/Client/ECS/Components/init.luau`):

```luau
local MyNewWorldComponents = require(ReplicatedStorage.Shared.ECS.Components.MyNewWorld)
local TableUtil = require(ReplicatedStorage.Shared.Util.TableUtil)

return {
    Default = TableUtil.link(Default, SharedDefault),
    MyNewWorld = MyNewWorldComponents,
}
```

Now you can access the new world and its components:

```luau
local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local Components = require(ReplicatedStorage.Client.ECS.Components)

local myWorld = Worlds.MyNewWorld
local myComponents = Components.MyNewWorld

local entity = myWorld:entity()
myWorld:set(entity, myComponents.MyComponent, "value")
```

## Components

Components are data structures attached to entities. They are defined in separate files for shared, client-specific, and server-specific components.

### Shared Components

Shared components are defined in `src/Shared/ECS/Components/SharedDefault.luau`. These components are available on both client and server.

```luau
local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

local WORLD = Worlds.Default

return {
    -- Tags (components with no data, used for identification)
    PlotTag = jecs.tag(),

    -- Data components
    Name = WORLD:component() :: Id<string>,
    Id = WORLD:component() :: Id<number>,
    OwnerId = WORLD:component() :: Id<number>,
    Node = WORLD:component() :: Id<BasePart>,
    Model = WORLD:component() :: Id<typeof(workspace.PlotTemplate)>,
    Purchases = WORLD:component() :: Id<{ [string]: true }>,
}
```

### Adding New Shared Components

To add a new shared component:

1. Open `src/Shared/ECS/Components/SharedDefault.luau`
2. Add your component definition:

```luau
-- For a simple data component
MyComponent = WORLD:component() :: Id<MyType>,

-- For a tag component (no data)
MyTag = jecs.tag(),
```

### Client/Server Specific Components

Client-specific components are defined in `src/Client/ECS/Components/Default.luau` and server-specific in `src/Server/ECS/Components/Default.luau`.

Currently these files are empty, but you can add components like:

```luau
local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

local WORLD = Worlds.Default

return {
    ClientOnlyComponent = WORLD:component() :: Id<string>,
}
```

The `init.luau` files in each ECS/Components folder combine the specific and shared components using `TableUtil.link()`.

## Entities

Entities are created using the world and can have components attached to them.

### Creating Entities

Entities are created using `world:entity()`:

```luau
local world = require(ReplicatedStorage.Shared.ECS.Worlds).Default
local entity = world:entity()
```

### Setting Components

Components can be set individually or in bulk.

#### Individual Component Setting

```luau
local components = require(ReplicatedStorage.Client.ECS.Components).Default

world:set(entity, components.Name, "My Entity")
world:set(entity, components.Id, 123)
```

#### Bulk Component Setting

Use the `ECSUtil.bulkSet` utility for setting multiple components at once:

```luau
local ECSUtil = require(ReplicatedStorage.Shared.Util.ECSUtil)
local components = require(ReplicatedStorage.Client.ECS.Components).Default

ECSUtil.bulkSet(world, entity, {
    [components.Name] = "My Entity",
    [components.Id] = 123,
    [components.Model] = myModel,
})
```

### Example Entity Creation

See `src/Client/ECS/Entities/ClientEntity.luau` and `src/Server/ECS/Entities/ServerEntity.luau` for examples:

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Components = require(ReplicatedStorage.Client.ECS.Components)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)
local ECSUtil = require(ReplicatedStorage.Shared.Util.ECSUtil)

local components = Components.Default

return {
    new = function(world: jecs.World, model: Model)
        local entity = world:entity()

        ECSUtil.bulkSet(world, entity, {
            [components.Name] = "MyEntity",
            [components.Model] = model,
        })

        return entity
    end,
}
```

## Usage in Scripts

### Client Script Example

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local Components = require(ReplicatedStorage.Client.ECS.Components)
local ClientEntity = require(ReplicatedStorage.Client.ECS.Entities.ClientEntity)
local ECSUtil = require(ReplicatedStorage.Shared.Util.ECSUtil)

local world = Worlds.Default
local components = Components.Default

-- Create an entity
local myEntity = ClientEntity.new(world, workspace.MyModel)

-- Add additional components
world:set(myEntity, components.OwnerId, game.Players.LocalPlayer.UserId)
```

### Server Script Example

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local Components = require(ServerStorage.Server.ECS.Components)
local ServerEntity = require(ServerStorage.Server.ECS.Entities.ServerEntity)
local ECSUtil = require(ReplicatedStorage.Shared.Util.ECSUtil)

local world = Worlds.Default
local components = Components.Default

-- Create an entity
local myEntity = ServerEntity.new(world, workspace.MyModel)

-- Add server-specific components
world:set(myEntity, components.Id, 456)
```

## Best Practices

1. **Component Naming**: Use PascalCase for component names.
2. **Type Safety**: Always type your components with `:: Id<Type>`.
3. **Shared vs Specific**: Put components in SharedDefault if they need to be accessed from both client and server.
4. **Entity Creation**: Create entity constructors in the respective Entities folders for reusable entity types.
5. **Bulk Operations**: Use `ECSUtil.bulkSet` when setting multiple components at once for better performance.

## Queries and Systems

For querying entities and creating systems, refer to the JECS documentation. Basic query example:

```luau
for entity in world:query(components.Name, components.Model) do
    local name = world:get(entity, components.Name)
    local model = world:get(entity, components.Model)
    -- Do something with the entity
end
```
