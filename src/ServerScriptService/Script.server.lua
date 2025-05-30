game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		local hitboxdebouncevalue = Instance.new("BoolValue", player.Character)
		hitboxdebouncevalue.Name = "HitboxDebounce"
		hitboxdebouncevalue.Value = false
		local M1Cooldown = Instance.new("NumberValue", player.Character)
		M1Cooldown.Name = "M1Cooldown"
		M1Cooldown.Value = 0
		local TimeStunned = Instance.new("NumberValue", player.Character)
		TimeStunned.Name = "TimeStunned"
		TimeStunned.Value = 0
		local HitboxCombo = Instance.new("IntValue", player.Character)
		HitboxCombo.Name = "HitboxCombo"
		HitboxCombo.Value = 0
		local M1Expiration = Instance.new("NumberValue", player.Character)
		M1Expiration.Name = "M1Expiration"
		M1Expiration.Value = 0
		local hitsound = Instance.new("Sound", player.Character.HumanoidRootPart)
		hitsound.SoundId = "rbxassetid://330595293"
		hitsound.Name = "HitSound"
		local swingsound = Instance.new("Sound", player.Character.HumanoidRootPart)
		swingsound.SoundId = "rbxassetid://74238153433253"
		swingsound.Name = "SwingSound"
		task.spawn(function()
			while true do
				task.wait(0.1)
				if TimeStunned.Value > 0 then
					TimeStunned.Value = TimeStunned.Value - 0.1
					local humanoid = TimeStunned.Parent:FindFirstChildOfClass("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = 8
					end
				else
					local humanoid = TimeStunned.Parent:FindFirstChildOfClass("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = 16
					end
				end
			end
		end)
		task.spawn(function()
			while true do
				task.wait(0.1)
				if M1Cooldown.Value > 0 then
					M1Cooldown.Value = M1Cooldown.Value - 0.1
				end
			end
		end)
		task.spawn(function()
			while true do
				task.wait(0.1)
				if M1Expiration.Value > 0 then
					M1Expiration.Value = M1Expiration.Value - 0.1
				end
			end
		end)
		task.spawn(function()
			while true do
				task.wait(0.1)
				if M1Expiration.Value <= 0 then
					HitboxCombo.Value = 0
				end
			end
		end)
	end)
end)

local module = require(game.ServerScriptService.Moduled)
game.ReplicatedStorage:WaitForChild("RemoteEvent").OnServerEvent:Connect(function(player)
	if player.Character:FindFirstChild("M1Cooldown").Value > 0 or player.Character:FindFirstChild("TimeStunned").Value > 0 then
		return
	end
	player.Character:FindFirstChild("M1Expiration").Value = 3
	player.Character:FindFirstChild("HitboxCombo").Value = player.Character:FindFirstChild("HitboxCombo").Value + 1
	if player.Character:FindFirstChild("HitboxCombo").Value < 4 then
		player.Character:FindFirstChild("M1Cooldown").Value = 0.4
	else
		player.Character:FindFirstChild("M1Cooldown").Value = 3
	end
	local whatever = module.GetHitbox(player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3.25), Vector3.new(3,3,3))
	if whatever[1][1] == nil then
		player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("SwingSound"):Play()
	end
	task.spawn(function()
		while whatever[2] ~= nil and whatever[2].Parent ~= nil do
			task.wait()
			for i, v in pairs(whatever[1]) do
				if v.Parent and v.Parent:FindFirstChild("Humanoid") then
					if v.Parent:FindFirstChild("HitboxDebounce").Value ~= true then
						if v.Parent ~= player.Character then
							if player.Character:FindFirstChild("HitboxCombo").Value < 4 then
								v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 4
							else
								v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 10
								player.Character:FindFirstChild("HitboxCombo").Value = 0
								module.Knockback(player.Character.HumanoidRootPart.CFrame.LookVector, v.Parent:FindFirstChild("HumanoidRootPart"), 0.3)
							end
							local hitsound = v.Parent:FindFirstChild("HumanoidRootPart"):FindFirstChild("HitSound")
							hitsound:Play()
							print(v)
							v.Parent:FindFirstChild("TimeStunned").Value = 1
							v.Parent:FindFirstChild("HitboxDebounce").Value = true
							task.spawn(function()
								task.wait(0.53)
								v.Parent:FindFirstChild("HitboxDebounce").Value = false
							end)
						end
					end
				end
			end
		end
	end)
	task.wait(0.5)
	whatever[2]:Destroy()
end)