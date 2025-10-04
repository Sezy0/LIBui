-- ============================================
-- NextUI Library - Example/Demo Script
-- ============================================

-- Load the library
local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- Create main window
local Window = NextUI:Window({
    Title = "NextUI Demo",
    Size = UDim2.new(0, 550, 0, 400)
})

-- ============================================
-- Section 1: Basic Components
-- ============================================
local Section1 = Window:Section("Basic Components")

Section1:Label("Welcome to NextUI! This is a modern dark theme library.")

Section1:Button("Click Me!", function()
    NextUI:Notification("Success", "Button was clicked!", 2)
end)

Section1:Toggle("Enable Feature", false, function(state)
    if state then
        NextUI:Notification("Enabled", "Feature is now ON", 2)
    else
        NextUI:Notification("Disabled", "Feature is now OFF", 2)
    end
end)

-- ============================================
-- Section 2: Sliders & Inputs
-- ============================================
local Section2 = Window:Section("Sliders & Inputs")

Section2:Slider("Volume", {
    Min = 0,
    Max = 100,
    Default = 50
}, function(value)
    print("Volume set to:", value)
end)

Section2:Slider("Speed", {
    Min = 16,
    Max = 500,
    Default = 16
}, function(value)
    print("Speed set to:", value)
end)

Section2:Input("Enter Your Name", "Type here...", function(text)
    NextUI:Notification("Input Received", "Hello, " .. text .. "!", 3)
end)

-- ============================================
-- Section 3: Dropdown Menu
-- ============================================
local Section3 = Window:Section("Dropdown Menu")

Section3:Dropdown("Select an Option", {
    "Option 1",
    "Option 2",
    "Option 3",
    "Custom Option"
}, function(selected)
    NextUI:Notification("Selected", "You chose: " .. selected, 2)
end)

-- ============================================
-- Section 4: Actions
-- ============================================
local Section4 = Window:Section("Actions")

Section4:Button("Show Notification", function()
    NextUI:Notification("Info", "This is a test notification!", 3)
end)

Section4:Button("Print to Console", function()
    print("Hello from NextUI!")
    NextUI:Notification("Console", "Check F9 Developer Console", 2)
end)

Section4:Toggle("Auto Farm", false, function(state)
    _G.AutoFarm = state
    print("Auto Farm:", state)
end)

-- Welcome notification
NextUI:Notification("Welcome!", "NextUI Demo loaded successfully", 3)

print("NextUI Demo loaded!")
