--! native

local rastersettings = require(game:GetService("ReplicatedStorage").rasterer)
local cam = workspace.CurrentCamera

local actor = script.Parent
local folder = actor.Parent

local linepositions = {}
local linecolors = {}

for i = 10, (#folder:GetChildren() - 1) * 10, 10 do
	for j = 1, 10 do -- paxal
		local pos = folder[i].AbsolutePosition + Vector2.new(folder[i].AbsoluteSize.X / 10 * j, folder[i].AbsoluteSize.Y / 2)
		table.insert(linepositions, pos)
	end
end

task.desynchronize()

local sund = rastersettings.sundirection

function renderline() 
	for i = 1, (#folder:GetChildren() - 1) * 10 do
		local p = linepositions[i]
		
		local direction = cam:ScreenPointToRay(p.X, p.Y).Direction * 4000
		local raycast = workspace:Raycast(cam.CFrame.Position, direction)
		local hit = raycast and raycast.Instance
		if hit then
			local initialcolor = Vector3.new(hit.Color.R * 510, hit.Color.G * 510, hit.Color.B * 700)
			local normal = raycast.Normal
			local pos = raycast.Position
			
			-- check if shadow
			local raycast2 = workspace:Raycast(pos + normal * 0.01, sund)
			if raycast2 then
				initialcolor *= Vector3.new(0.7, 0.7, 0.7)
			end
			
			local raycast3 = direction - 2 * direction:Dot(normal) * normal -- light bounce
			local specular = raycast3:Angle(sund)
			
			initialcolor *= 1 - (normal:Angle(sund) + math.min(specular ^ 5, 0.3)) / math.pi -- linear shading + specular
			
			local reflectance = raycast.Instance.Reflectance
			if reflectance > 0 then
				local reflection = workspace:Raycast(pos, raycast3)
				if reflection then
					local reflectioncolor = reflection.Instance.Color
					local pos2 = reflection.Position
					local normal2 = reflection.Normal

					reflection = Vector3.new(reflectioncolor.R * 510, reflectioncolor.G * 510, reflectioncolor.B * 700)

					local secondaryshadow = workspace:Raycast(pos2 + normal2 * 0.01, sund)
					if secondaryshadow then
						reflection *= Vector3.new(0.7, 0.7, 0.7)
					end

					local specular2 = raycast3:Angle(raycast3 - 2 * direction:Dot(normal2) * normal2)
					reflection *= 1 - (normal2:Angle(sund) + math.min(specular2 ^ 5, 0.3)) / math.pi

					initialcolor *= 1 - reflectance
					initialcolor += reflection * reflectance
				else
					local sun = math.clamp((180 - raycast3:Angle(sund) / math.pi * 180) ^ 1.45 - 1700, 0, 255)
					local bottomsky = raycast3:Angle(Vector3.yAxis) / math.pi
					local sky = 1 - bottomsky
					
					initialcolor *= 1 - reflectance
					initialcolor += Vector3.new(math.min(140 * sky + sun + 280 * bottomsky - 30, 255), math.min(186 * sky + sun + 280 * bottomsky - 30, 255), math.min(255 * sky + sun + 320 * bottomsky - 30, 255)) * reflectance
				end
			end
			
			linecolors[i] = Color3.fromRGB(math.clamp(initialcolor.X, 0, 255), math.clamp(initialcolor.Y, 0, 255), math.clamp(initialcolor.Z, 0, 255))
			continue
		end
		
		local sun = math.clamp((180 - direction:Angle(sund) / math.pi * 180) ^ 1.45 - 1700, 0, 255)
		local bottomsky = direction:Angle(Vector3.yAxis) / math.pi
		local sky = 1 - bottomsky
			
		linecolors[i] = Color3.fromRGB(math.min(140 * sky + sun + 280 * bottomsky - 30, 255), math.min(186 * sky + sun + 280 * bottomsky - 30, 255), math.min(255 * sky + sun + 320 * bottomsky - 30, 255))
	end
	
	actor:SendMessage("renderpixel", linecolors)
end

while task.wait(1 / rastersettings.targetfps) do
	renderline()
end
