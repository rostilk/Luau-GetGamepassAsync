local url = "https://script.google.com/macros/s/PASTE_YOUR_ID_HERE_AND_DONT_SHARE_WITH_ANYONE/exec"

local HttpService = game:GetService("HttpService")
local HttpProxy = {}

function JSONDecode(JSON)
	local t = {}
	
	local succ, err = pcall(function()
		t = HttpService:JSONDecode(JSON)
	end)
	
	if not succ then
		warn(err)
	end
	
	return t
end

function HttpProxy:GetAsync(link)
	local proxyUrl = url .. "?q=" .. HttpService:UrlEncode(link)
	local data = JSONDecode(raw)

	if data and data.result == "success" then
		return data.response
	else
		warn(data and data.error or "Proxy request failed")
	end
end


return HttpProxy
