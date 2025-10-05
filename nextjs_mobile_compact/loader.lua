-- ============================================
-- NextUI Mobile Compact - Loader Example
-- ============================================

local NextUI = loadstring(game:HttpGet("https://pastebin.com/raw/cSDyP4Ta"))()

-- Configuration
local Config = {
    UseKeySystem = true,  -- Set to true to enable key system
    KeyUrl = "https://raw.githubusercontent.com/Sezy0/LIBui/main/key.txt",
    LogoId = "133508780883906",
    DiscordLink = "https://discord.gg/your-invite"
}

-- Start authentication
NextUI:Auth({
    UseKeySystem = Config.UseKeySystem,
    KeyUrl = Config.KeyUrl,
    LogoId = Config.LogoId,
    DiscordLink = Config.DiscordLink,
    OnSuccess = function()
        -- This runs after successful authentication
        
        -- Create your UI here
        local Window = NextUI:Window({
            Title = "Mobile UI Demo"
        })

        -- Tab 1: Home
        local HomeTab = Window:Tab("Home")
        local Section1 = HomeTab:Section("Welcome")
        
        Section1:Label("Welcome to NextUI Mobile Compact!")
        Section1:Label("Optimized for mobile devices")
        
        Section1:Button("Test Button", function()
            NextUI:Notification("Success", "Button clicked!", 2)
        end)

        -- Tab 2: Features
        local FeaturesTab = Window:Tab("Features")
        local Section2 = FeaturesTab:Section("UI Elements")
        
        Section2:Toggle("Auto Farm", false, function(value)
            print("Auto Farm:", value)
        end)
        
        Section2:Toggle("ESP", false, function(value)
            print("ESP:", value)
        end)
        
        Section2:Label("More features coming soon...")

        -- Tab 3: Settings
        local SettingsTab = Window:Tab("Settings")
        local Section3 = SettingsTab:Section("Configuration")
        
        Section3:Toggle("Notifications", true, function(value)
            print("Notifications:", value)
        end)
        
        Section3:Button("Reset Settings", function()
            NextUI:Notification("Info", "Settings reset!", 2)
        end)
    end
})
