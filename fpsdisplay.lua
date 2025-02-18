local rs = game:GetService("RunService")

local pfps = 60

rs.RenderStepped:Connect(function(dt)
	pfps = pfps * 0.9 + 0.1 / dt
	script.Parent.Text = math.round(pfps).." fps"
end)
