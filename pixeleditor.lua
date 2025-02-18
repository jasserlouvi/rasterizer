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
	folder[i].UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, rowcolors[1]),
		ColorSequenceKeypoint.new(0.1, rowcolors[1]),
		ColorSequenceKeypoint.new(0.101, rowcolors[2]),
		ColorSequenceKeypoint.new(0.2, rowcolors[2]),
		ColorSequenceKeypoint.new(0.201, rowcolors[3]),
		ColorSequenceKeypoint.new(0.3, rowcolors[3]),
		ColorSequenceKeypoint.new(0.301, rowcolors[4]),
		ColorSequenceKeypoint.new(0.4, rowcolors[4]),
		ColorSequenceKeypoint.new(0.401, rowcolors[5]),
		ColorSequenceKeypoint.new(0.5, rowcolors[5]),
		ColorSequenceKeypoint.new(0.501, rowcolors[6]),
		ColorSequenceKeypoint.new(0.6, rowcolors[6]),
		ColorSequenceKeypoint.new(0.601, rowcolors[7]),
		ColorSequenceKeypoint.new(0.7, rowcolors[7]),
		ColorSequenceKeypoint.new(0.701, rowcolors[8]),
		ColorSequenceKeypoint.new(0.8, rowcolors[8]),
		ColorSequenceKeypoint.new(0.801, rowcolors[9]),
		ColorSequenceKeypoint.new(0.9, rowcolors[9]),
		ColorSequenceKeypoint.new(0.901, rowcolors[10]),
		ColorSequenceKeypoint.new(1, rowcolors[10])
	})
end
