local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local StarterGui = game:GetService("StarterGui")

local __LoadOrder = require(ServerStorage.Server.__LoadOrder)

-------------------------------------------------------------------------------
-- LOGIC
-------------------------------------------------------------------------------

do
	-- This fixes the "Write Marshalled" freeze bug
	if RunService:IsStudio() then
		for i = 1, 10 do
			local s = Instance.new("Script", workspace)
			task.delay(math.random(20, 30) / 10, s.Destroy, s)
		end
	end

	local start = os.clock()

	-- Load ECS
	require(ReplicatedStorage.Shared.ECS.Worlds)
	for _, parent in { ReplicatedStorage.Shared.ECS.Components, ServerStorage.Server.ECS.Components } do
		for _, child: ModuleScript in parent:GetChildren() do
			require(child)
		end
	end

	-- Load interfaces
	local interfaces = Instance.new("Folder")
	interfaces.Name = "__INTERFACES"
	for _, v in next, StarterGui:GetChildren() do
		v.Parent = interfaces
	end
	interfaces.Parent = ReplicatedStorage

	-- Require modules
	local modules: { { Name: string, Module: any } } = {}
	for _, module in next, __LoadOrder do
		table.insert(modules, { Name = module.Name, Module = require(module) })
	end

	-- Run .init
	for _, m in next, modules do
		if m.Module.init then
			m.Module.init()
			m.Module.init = nil
		end
	end

	-- Run start
	for _, m in next, modules do
		if m.Module.start then
			task.spawn(m.Module.start)
			m.Module.start = nil
		end
	end

	print(string.format("✅ Server loaded in %.6f seconds", os.clock() - start))
end
