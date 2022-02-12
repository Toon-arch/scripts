local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local CreateTag = function(base, role, fakedname)
    local bb = Instance.new("BillboardGui")
    bb.Parent = CoreGui
    bb.Adornee = base
    bb.ExtentsOffset = Vector3.new(0, 1, 0)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 5, 0, 5)
    bb.StudsOffset = Vector3.new(0, 1, 0)
    bb.Name = "tracker"
    local frame = Instance.new("Frame")
    frame.Parent = bb
    frame.ZIndex = 10
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(1, 0, 1, 0)
    local txtlbl = Instance.new("TextLabel")
    txtlbl.Parent = bb
    txtlbl.ZIndex = 10
    txtlbl.BackgroundTransparency = 1
    txtlbl.Position = UDim2.new(0, 0, 0, -35)
    txtlbl.Size = UDim2.new(1, 0, 10, 0)
    txtlbl.Font = "ArialBold"
    txtlbl.FontSize = "Size12"
    txtlbl.Text = fakedname .. " - " .. role
    txtlbl.TextStrokeTransparency = 0.5
    if role == "Murderer" then
        txtlbl.TextColor3 = Color3.new(250, 0, 0)
        frame.BackgroundColor3 = Color3.new(250, 0, 0)
    end
    if role == "Sheriff" then
        txtlbl.TextColor3 = Color3.new(0, 0, 250)
        frame.BackgroundColor3 = Color3.new(0, 0, 250)
    end
end

local ClearAllTrackers = function()
    for _,v in pairs(CoreGui:GetChildren()) do
        if v.Name == "tracker" and v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
end

local StartTrackingPlayers = function()
    ClearAllTrackers()
    local track = true
    spawn(function()
        while wait(1) do
            pcall(function()
                if track then
                    ClearAllTrackers()
                    for _, v in pairs(Players:GetChildren()) do
                        if v.Status.Role.Value == "Murderer" then
                            if v and v.Character:FindFirstChild("Head") then
                                CreateTag(v.Character.Head, "Murderer", v.Status.FakeName.Value)
                            end
                        else if v.Status.HasRevolver.Value == true then
                            if v.Character and v.Character:FindFirstChild("Head") then
                                CreateTag(v.Character.Head, "Sheriff", v.Status.FakeName.Value)
                            end
                        else if v.Character and v.Character:FindFirstChild("Head") then
                                    CreateTag(v.Character.Head, "Bystander", v.Status.FakeName.Value)
                                end
                            end
                        end
                    end
                end
                wait(1)
            end)
        end
    end)
end

ClearAllTrackers()
StartTrackingPlayers()
