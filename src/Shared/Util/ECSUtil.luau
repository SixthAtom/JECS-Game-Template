local ECSUtil = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

-------------------------------------------------------------------------------
-- TYPES
-------------------------------------------------------------------------------

type World = jecs.World
type Entity<T = nil> = jecs.Entity<T>

-------------------------------------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------------------------------------

function ECSUtil.bulkSet<E, C>(world: World, entity: E, components: C)
	for i, v in components :: { [Entity<any>]: any } do
		world:set(entity, i, v)
	end
end

return ECSUtil
