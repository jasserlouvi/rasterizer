--! native

local rastersettings = require(game:GetService("ReplicatedStorage").rasterer)
local resolution = rastersettings.resolution

local actor = script.Parent
local folder = actor.Parent

local rowcolors = {}

local step = 1

function renderpixel(colors) 
	rowcolors = colors
end

actor:BindToMessage("renderpixel", renderpixel)

while task.wait(1 / rastersettings.refreshrate) do
	for i = 10, #rowcolors, 10 do
		folder[i].UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, rowcolors[i - 9]),
			ColorSequenceKeypoint.new(0.1, rowcolors[i - 9]),
			ColorSequenceKeypoint.new(0.101, rowcolors[i - 8]),
			ColorSequenceKeypoint.new(0.2, rowcolors[i - 8]),
			ColorSequenceKeypoint.new(0.201, rowcolors[i - 7]),
			ColorSequenceKeypoint.new(0.3, rowcolors[i - 7]),
			ColorSequenceKeypoint.new(0.301, rowcolors[i - 6]),
			ColorSequenceKeypoint.new(0.4, rowcolors[i - 6]),
			ColorSequenceKeypoint.new(0.401, rowcolors[i - 5]),
			ColorSequenceKeypoint.new(0.5, rowcolors[i - 5]),
			ColorSequenceKeypoint.new(0.501, rowcolors[i - 4]),
			ColorSequenceKeypoint.new(0.6, rowcolors[i - 4]),
			ColorSequenceKeypoint.new(0.601, rowcolors[i - 3]),
			ColorSequenceKeypoint.new(0.7, rowcolors[i - 3]),
			ColorSequenceKeypoint.new(0.701, rowcolors[i - 2]),
			ColorSequenceKeypoint.new(0.8, rowcolors[i - 2]),
			ColorSequenceKeypoint.new(0.801, rowcolors[i - 1]),
			ColorSequenceKeypoint.new(0.9, rowcolors[i - 1]),
			ColorSequenceKeypoint.new(0.901, rowcolors[i]),
			ColorSequenceKeypoint.new(1, rowcolors[i])
		})
	end
end
