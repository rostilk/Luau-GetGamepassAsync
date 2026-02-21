--[[
  Script located in ServerScriptService
--]]

local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local GoogleProxy = require(ServerScriptService.GoogleProxy) -- Your path to module.

--------------------------------------------------------------------

local function getUniverseId(placeId: number)
	local data = GoogleProxy:GetAsync(
		`https://apis.roproxy.com/universes/v1/places/{placeId}/universe`
	)

	if data and data.universeId then
		return data.universeId
	else
		warn("Can't fetch universe for place:", placeId)
	end
end

--------------------------------------------------------------------

local function getUniversesByUserId(userId: number)
	local universes = {}
	local cursor = ""

	repeat
		local url = `https://games.roblox.com/v2/users/{userId}/games?limit=50&cursor={cursor}`
		local data = GoogleProxy:GetAsync(url)

		if not data then break end

		for _, gameData in ipairs(data.data) do
			local universeId = gameData.id

			if not table.find(universes, universeId) then
				table.insert(universes, universeId)
			end
		end

		cursor = data.nextPageCursor
	until not cursor

	return universes
end

--------------------------------------------------------------------

local function getGamepasses(universeIds)
	local allPasses = {}
	local done = 0

	for _, universeId in ipairs(universeIds) do
		local cursor = ""
		
		done += 1

		task.spawn(function()
			local url =
				`https://apis.roproxy.com/game-passes/v1/universes/{universeId}/game-passes?limit=100`

			local data = GoogleProxy:GetAsync(url)

			if data then
				for _, pass in ipairs(data.gamePasses) do
					table.insert(allPasses, pass)
				end
			end

			done -= 1
		end)
	end


	repeat task.wait() until done == 0

	return allPasses
end

--------------------------------------------------------------------

Players.PlayerAdded:Connect(function(player)
	print("Loading data for", player.Name)

	local universes = getUniversesByUserId(1553277233) -- pass someones player id

	print("Universes:", universes)

	local passes = getGamepasses(universes)


	print("TOTAL PASSES:", #passes)
	print(passes)

-- do your stuff.
end)
