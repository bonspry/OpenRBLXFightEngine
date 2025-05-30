local multifunctionmodule = {}
local isstudio = game:GetService("RunService"):IsStudio()

function multifunctionmodule.GetHitbox(cframe,size)
	local Hitbox = Instance.new("Part", workspace)
	if isstudio == true then
		Hitbox.Transparency = 0.75
	else
		Hitbox.Transparency = 1
	end
	Hitbox.CanCollide = false
	Hitbox.Anchored = true
	Hitbox.CFrame = cframe
	Hitbox.Size = size
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {}
	local result = game.Workspace:GetPartsInPart(Hitbox, params)
	return {result, Hitbox}
end

function multifunctionmodule.Knockback(direction, humanoidrootpart, duration)
	local unitDirection = direction.Unit
	local knockbackDistance = 7
	local speed = knockbackDistance / duration
	local velocity = unitDirection * speed
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = velocity
	bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
	bodyVelocity.P = 100000
	bodyVelocity.Parent = humanoidrootpart
	task.delay(duration, function()
		if bodyVelocity and bodyVelocity.Parent then
			bodyVelocity:Destroy()
		end
	end)
end

return multifunctionmodule
