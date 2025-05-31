local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local mouse_held = false
local hb = game:GetService("RunService").Heartbeat

-- // hold click to attack \\ --
-- || made by: @dukapanzer || --
mouse.Button1Down:Connect(function()
	mouse_held = true
end)

mouse.Button1Up:Connect(function()
	mouse_held = false
end)

hb:Connect(function()
	if mouse_held then
		game.ReplicatedStorage.RemoteEvent:FireServer()
	end
end)
-- || made by: @dukapanzer || --
-- \\ hold click to attack // --
