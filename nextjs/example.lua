-- ============================================
-- NextUI Simple Example (No Key System)
-- ============================================

local NextUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sezy0/LIBui/main/nextjs/init.lua"))()

-- Bypass authentication (no key required)
NextUI:ValidateKey("bypass", nil)

-- Create Main UI
local Window = NextUI:Window({
    Title = "NextUI Library",
    Size = UDim2.new(0, 600, 0, 450)
})

-- Tab 1: Home
local Tab1 = Window:Tab({
    Name = "🏠 Home",
    Icon = nil
})

local Section1 = Tab1:Section("Welcome")

Section1:Label("Welcome to NextUI!")
Section1:Label("✨ Created by FoxZy")

Section1:Button({
    Text = "Test Button",
    Callback = function()
        NextUI:Notification("Success", "Button clicked!", 2)
    end
})

Section1:Button({
    Text = "Another Button",
    Callback = function()
        print("Another button clicked!")
    end
})

-- Tab 2: Components
local Tab2 = Window:Tab({
    Name = "🎨 Components",
    Icon = nil
})

local Section2 = Tab2:Section("Interactive Elements")

Section2:Toggle({
    Text = "Example Toggle",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

Section2:Slider({
    Text = "Example Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Slider:", value)
    end
})

Section2:Dropdown({
    Text = "Example Dropdown",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(value)
        print("Selected:", value)
    end
})

Section2:Input({
    Text = "Example Input",
    Placeholder = "Enter text...",
    Callback = function(value)
        print("Input:", value)
    end
})

-- Tab 3: Settings
local Tab3 = Window:Tab({
    Name = "⚙️ Settings",
    Icon = nil
})

local Section3 = Tab3:Section("Configuration")

Section3:Label("This is a label")
Section3:Label("Labels are for displaying text")

Section3:Button({
    Text = "Show Notification",
    Callback = function()
        NextUI:Notification("Info", "This is a notification!", 3)
    end
})

print("NextUI loaded successfully!")
