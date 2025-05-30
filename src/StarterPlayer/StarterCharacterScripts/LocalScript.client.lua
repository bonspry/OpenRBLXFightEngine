local player = game.Players.LocalPlayer
player:GetMouse().Button1Down:Connect(function()
	game.ReplicatedStorage.RemoteEvent:FireServer()
end)