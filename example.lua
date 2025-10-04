-- ============================================
-- NextUI Library - Complete Example
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- Create Window
local Window = NextUI:Window({
    Title = "My App",
    Icon = 133508780883906,
    Size = UDim2.new(0, 550, 0, 450)
})

-- ============================================
-- Section 1: Basic Controls
-- ============================================
local Section1 = Window:Section("Basic Controls")

Section1:Label("Welcome! This is a demo of NextUI components.")

Section1:Button("Click Me", function()
    print("Button clicked!")
    NextUI:Notification("Success", "Button was clicked!", 2)
end)

Section1:Toggle("Enable Feature", false, function(state)
    print("Toggle:", state)
end)

-- ============================================
-- Section 2: Sliders
-- ============================================
local Section2 = Window:Section("Sliders")

Section2:Slider("Volume", {
    Min = 0,
    Max = 100,
    Default = 50
}, function(value)
    print("Volume:", value)
end)

Section2:Slider("Speed", {
    Min = 16,
    Max = 200,
    Default = 16
}, function(value)
    print("Speed:", value)
end)

Section2:Slider("FOV", {
    Min = 70,
    Max = 120,
    Default = 90
}, function(value)
    print("FOV:", value)
end)

-- ============================================
-- Section 3: Dropdown & Input
-- ============================================
local Section3 = Window:Section("Dropdown & Input")

Section3:Dropdown("Select Quality", {
    "Low",
    "Medium",
    "High",
    "Ultra",
    "Extreme"
}, function(selected)
    print("Quality:", selected)
    NextUI:Notification("Quality Changed", "Set to: " .. selected, 2)
end)

Section3:Input("Username", "Enter your name...", function(text)
    print("Username:", text)
    NextUI:Notification("Input Received", "Hello, " .. text .. "!", 2)
end)

-- ============================================
-- Section 4: More Controls
-- ============================================
local Section4 = Window:Section("More Controls")

Section4:Toggle("Auto Farm", false, function(state)
    _G.AutoFarm = state
    print("Auto Farm:", state)
end)

Section4:Toggle("ESP", false, function(state)
    _G.ESP = state
    print("ESP:", state)
end)

Section4:Button("Teleport to Spawn", function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        NextUI:Notification("Teleported", "Moved to spawn!", 2)
    end
end)

Section4:Button("Reset Character", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

-- Welcome notification
NextUI:Notification("Welcome!", "NextUI loaded successfully", 3)

print("NextUI Example loaded!")
