-- ============================================
-- NextUI Library - Complete Example with Tabs
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- Create Window
local Window = NextUI:Window({
    Title = "My App",
    Icon = 133508780883906,
    Size = UDim2.new(0, 650, 0, 450)
})

-- ============================================
-- Tab 1: Home
-- ============================================
local HomeTab = Window:Tab("Home")

local WelcomeSection = HomeTab:Section("Welcome")
WelcomeSection:Label("Welcome to NextUI! Navigate using the sidebar.")

local BasicSection = HomeTab:Section("Basic Controls")

BasicSection:Button("Click Me", function()
    print("Button clicked!")
    NextUI:Notification("Success", "Button was clicked!", 2)
end)

BasicSection:Toggle("Enable Feature", false, function(state)
    print("Toggle:", state)
end)

-- ============================================
-- Tab 2: Settings
-- ============================================
local SettingsTab = Window:Tab("Settings")

local AudioSection = SettingsTab:Section("Audio")

AudioSection:Slider("Volume", {
    Min = 0,
    Max = 100,
    Default = 50
}, function(value)
    print("Volume:", value)
end)

local GraphicsSection = SettingsTab:Section("Graphics")

GraphicsSection:Slider("FOV", {
    Min = 70,
    Max = 120,
    Default = 90
}, function(value)
    print("FOV:", value)
end)

GraphicsSection:Dropdown("Quality", {
    "Low",
    "Medium",
    "High",
    "Ultra"
}, function(selected)
    print("Quality:", selected)
    NextUI:Notification("Quality Changed", "Set to: " .. selected, 2)
end)

-- ============================================
-- Tab 3: Player
-- ============================================
local PlayerTab = Window:Tab("Player")

local MovementSection = PlayerTab:Section("Movement")

MovementSection:Slider("Speed", {
    Min = 16,
    Max = 200,
    Default = 16
}, function(value)
    print("Speed:", value)
end)

local ActionsSection = PlayerTab:Section("Actions")

ActionsSection:Button("Teleport to Spawn", function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        NextUI:Notification("Teleported", "Moved to spawn!", 2)
    end
end)

-- Welcome notification
NextUI:Notification("Welcome!", "NextUI loaded with tabs!", 3)

print("NextUI Example with Tabs loaded!")
