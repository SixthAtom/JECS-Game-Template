local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Default = require(ServerStorage.Server.ECS.Components.Default)
local SharedDefault = require(ReplicatedStorage.Shared.ECS.Components.SharedDefault)
local TableUtil = require(ReplicatedStorage.Shared.Util.TableUtil)

-------------------------------------------------------------------------------
-- RETURN
-------------------------------------------------------------------------------

return {
	Default = TableUtil.link(Default, SharedDefault),
}
