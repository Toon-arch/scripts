local Players = game:GetService("Players")
local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Toon-arch/scripts/main/be_dead_forever_simulator/library.lua"))()
local window1 = library:Window("Scripts")
local window2 = library:Window("LocalPlayer")

library:Keybind("Q")

window1:Button("Deadcoins Autofarm", function()
    for i,v in pairs(workspace:GetDescendants()) do
		if tostring(v.Name) == "Computer" and v:FindFirstChild("Monitor") then
			for i2,v2 in pairs(v.Monitor:GetDescendants()) do
				if v2:IsA("ClickDetector") and v2.Name == "ClickDetector" then
					spawn(function()
						fireclickdetector(v2, 0)
						while wait(0.5) do
							fireclickdetector(v2, 0)
						end
					end)
				end
			end
		end
	end
end)

window1:Button("Rejoin", function()
    local TeleportService = game:GetService("TeleportService")
	if #Players:GetPlayers() <= 1 then
		Players.LocalPlayer:Kick("\nRejoining...")
		wait()
		TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
	end
end)

window1:Button("Anti Afk", function()
    local getcons = getconnections or get_signal_cons
	if getcons then
		for i,v in pairs(getcons(Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
	end
end)

window1:Button("Remove Cars on Client", function()
    local match = function(str1, str2)
		return string.find(string.lower(tostring(str1)), string.lower(tostring(str2)))
	end
	while wait(1) do
		for i,v in pairs(workspace:GetChildren()) do
			if match(v.Name, "goodcar") then
				v:Remove()
			end
			if match(v.Name, "bestmovingcar") then
				v:Remove()
			end
		end
	end
end)

window2:Button("Bind Shiftlock to LeftCtrl", function()
    local LocalPlayer = Players.LocalPlayer
	if not LocalPlayer then return end
	local NewLockKey = "LeftControl"
	local MouseLockController = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
	local Object = MouseLockController:FindFirstChild("BoundKeys")
	if Object then
		Object.Value = NewLockKey
	else
		Object = Instance.new("StringValue")
		Object.Name = "BoundKeys"
		Object.Value = NewLockKey
		Object.Parent = MouseLockController
	end
end)

window2:Button("Medkit", function()
    if workspace:FindFirstChild("Meshes/Medkit") then
		for i,v in pairs(workspace["Meshes/Medkit"]:GetDescendants()) do
			if v:IsA("ClickDetector") and v.Name == "ClickDetector" then
				fireclickdetector(v, 0)
			end
		end
	end
end)

window2:Button("Burger", function()
    if workspace:FindFirstChild("burgre") then
		for i,v in pairs(workspace.burgre:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v, 0)
			end
		end
	end
end)

window2:Button("Soda", function()
    local VendingMachine = nil
	for i,v in pairs(workspace:GetChildren()) do
		if string.lower(tostring(v.Name)) == "vending machine" then
			for i2,v2 in pairs(v:GetDescendants()) do
				if v2:IsA("ClickDetector") then
					VendingMachine = v2
				end
			end
		end
	end
	if VendingMachine ~= nil then
		fireclickdetector(VendingMachine, 0)
	end
end)

window2:Button("Show Mobile Sprint Toggle", function()
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if not PlayerGui and not PlayerGui:FindFirstChild("RunButton") then return end
	local RunButton = PlayerGui.RunButton
	if RunButton:FindFirstChild("Button") then
		RunButton.Button.ImageTransparency = 0
		if RunButton.Button:FindFirstChild("LocalScript") then
			RunButton.Button.LocalScript.Disabled = false
		end
	end
	RunButton.Enabled = true
end)

window2:Button("Enable Chat", function()
    game:GetService("StarterGui"):SetCoreGuiEnabled("Chat", true)
end)

spawn(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {     
        ["Title"] = "bdfs",
        ["Text"] = "toggle gui: Q"
    })
end)
