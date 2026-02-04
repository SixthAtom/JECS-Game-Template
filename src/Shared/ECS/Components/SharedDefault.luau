local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Worlds = require(ReplicatedStorage.Shared.ECS.Worlds)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

-------------------------------------------------------------------------------
-- CONSTANTS
-------------------------------------------------------------------------------

local WORLD = Worlds.Default

-------------------------------------------------------------------------------
-- TYPES
-------------------------------------------------------------------------------

type Id<T = nil> = jecs.Id<T>

-------------------------------------------------------------------------------
-- RETURN
-------------------------------------------------------------------------------

return {
	Name = WORLD:component() :: Id<string>,
	Id = WORLD:component() :: Id<number>,
	OwnerId = WORLD:component() :: Id<number>,
	Node = WORLD:component() :: Id<BasePart>,
	Model = WORLD:component() :: Id<typeof(workspace.PlotTemplate)>,
	Purchases = WORLD:component() :: Id<{ [string]: true }>,
}
