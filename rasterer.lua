local tcs = game:GetService("TextChatService")
local player = game:GetService("Players").LocalPlayer
local playergui = player.PlayerGui

local display = playergui.ScreenGui.rasterdisplay

function refreshscreen() 
	local folders = display:GetChildren()
	for i = 1, #folders do
		if folders[i]:IsA("Folder") then
			folders[i]:Destroy()
		end
	end
	
	display.LocalScript.Enabled = false
	display.LocalScript.Enabled = true
end

local rasterer = {}

local commandsinfo = {
	["quality_level"] = {
		["1"] = {
			resolution = 50
		},
		["2"] = {
			resolution = 100
		},
		["3"] = {
			resolution = 150
		},
		["4"] = {
			resolution = 200
		},
		["5"] = {
			resolution = 280
		},
		--[["6"] = {
			resolution = 400
		}]]
	}
}

tcs.SendingMessage:Connect(function(txt)
	txt = string.split(txt.Text, " ")

	if txt[1] == "set" then
		local cmdinfo = commandsinfo[txt[2]]
		if cmdinfo then
			for i, v in cmdinfo[txt[3]] do
				rasterer[i] = v
			end

			refreshscreen()
		end
	end
end)

rasterer.resolution = 100 -- using paxals, so has to be a multiple of 10
rasterer.targetfps = 60
rasterer.refreshrate = 60

rasterer.sundirection = Vector3.new(1000, 1000, 1000)

return rasterer
