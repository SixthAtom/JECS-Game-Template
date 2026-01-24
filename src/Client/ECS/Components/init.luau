local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Default = require(ReplicatedStorage.Client.ECS.Components.Default)
local SharedDefault = require(ReplicatedStorage.Shared.ECS.Components.SharedDefault)
local TableUtil = require(ReplicatedStorage.Shared.Util.TableUtil)

-------------------------------------------------------------------------------
-- RETURN
-------------------------------------------------------------------------------

return {
	Default = TableUtil.link(Default, SharedDefault),
}
