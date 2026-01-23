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

type Entity<T = nil> = jecs.Entity<T>

-------------------------------------------------------------------------------
-- RETURN
-------------------------------------------------------------------------------

return {}
