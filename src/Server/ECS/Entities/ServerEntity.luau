local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Components = require(ReplicatedStorage.Client.ECS.Components)
local jecs = require(ReplicatedStorage.Shared.Packages.jecs)
local ECSUtil = require(ReplicatedStorage.Shared.Util.ECSUtil)

-------------------------------------------------------------------------------
-- PRIVATE VARIABLES
-------------------------------------------------------------------------------

local components = Components.Default

return {
	new = function(world: jecs.World, model: Model)
		local yourServerEntity = world:entity()

		ECSUtil.bulkSet(world, yourServerEntity, {
			[components.Name] = "YourServerEntity",
			[components.Model] = model,
		})

		return yourServerEntity
	end,
}
