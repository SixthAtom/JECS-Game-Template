local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local __LoadOrder = require(ReplicatedStorage.Client.__LoadOrder)

-------------------------------------------------------------------------------
-- PRIVATE VARIABLES
-------------------------------------------------------------------------------

local player = Players.LocalPlayer

-------------------------------------------------------------------------------
-- LOGIC
-------------------------------------------------------------------------------

do
	local start = os.clock()

	-- Load ECS
	require(ReplicatedStorage.Shared.ECS.Worlds)
	for _, parent in { ReplicatedStorage.Shared.ECS.Components, ReplicatedStorage.Client.ECS.Components } do
		for _, child: ModuleScript in parent:GetChildren() do
			require(child)
		end
	end

	-- Load interfaces
	local interfaces: Folder = ReplicatedStorage:WaitForChild("__INTERFACES")
	for _, v in interfaces:GetChildren() do
		v:Clone().Parent = player.PlayerGui
	end

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

	print(`Hello {player.DisplayName}, welcome!`)
	print(string.format("✅ Client loaded in %.6f seconds", os.clock() - start))
end
