local TableUtil = {}

-------------------------------------------------------------------------------
-- PRIVATE VARIABLES
-------------------------------------------------------------------------------

local linkedTables = {}

-------------------------------------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------------------------------------

function TableUtil.link<T, J>(t1: T, t2: J): T & J
	if not linkedTables[t1] then
		linkedTables[t1] = {}
	end

	if not linkedTables[t1][t2] then
		linkedTables[t1][t2] = setmetatable(t1, {
			__index = function(_, i)
				return t2[i]
			end,

			__newindex = function(_, i, v)
				t2[i] = v
			end,
		})
	end

	return linkedTables[t1][t2]
end

function TableUtil.negate<T>(t1: T, t2)
	for key, _ in pairs(t2) do
		t1[key] = nil
	end
	return t1
end

function TableUtil.set<T>(t: T, i: any, v: any)
	t[i] = v
	return t
end

return TableUtil
