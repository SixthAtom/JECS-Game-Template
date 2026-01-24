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
		local yourClientEntity = world:entity()

		ECSUtil.bulkSet(world, yourClientEntity, {
			[components.Name] = "YourClientEntity",
			[components.Model] = model,
		})

		return yourClientEntity
	end,
}
