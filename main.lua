local players = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local rs = game:GetService("RunService")
local player = players.LocalPlayer

task.wait(0.05)

local cam = workspace.CurrentCamera

local display = script.Parent
local pixel = script.paxel

local core = script.Actor

local rastersettings = require(rep.rasterer)

local resolution = rastersettings.resolution

local pixelsize = UDim2.fromScale(10 / resolution, 2 / resolution) -- a paxal is 10 pixels horizontally

pixel.Size = pixelsize

local threads = {}

for i = 1, math.floor(resolution / 2) do
	table.insert(threads, {})
end

for y = 0, 1 - pixelsize.Y.Scale, pixelsize.Y.Scale do
	for x = 0, 1, pixelsize.X.Scale do
		local newp = pixel:Clone()
		newp.Parent = display
		newp.Position = UDim2.fromScale(x, y)
		--newp.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
		
		table.insert(threads[math.ceil(y * resolution / 2) + 1], newp)
	end
end

--local threadsteps = {}

for i = 1, #threads do
	local newfolder = Instance.new("Folder", display)
	newfolder.Name = i
	
	local thread = threads[i]
	for j = 1, #thread do
		thread[j].Parent = newfolder
		thread[j].Name = j * 10
	end
	
	local newcore = core:Clone()
	newcore.Parent = newfolder
	newcore.pixeleditor.Enabled = true
	newcore.raycaster.Enabled = true
	
	--table.insert(threadsteps, 0)
end
