local ReplicatedStorage = game:GetService("ReplicatedStorage")

local jecs = require(ReplicatedStorage.Shared.Packages.jecs)

-------------------------------------------------------------------------------
-- RETURN
-------------------------------------------------------------------------------

return {
	Default = jecs.world(),
}
